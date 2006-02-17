Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932534AbWBQHBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbWBQHBO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 02:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161147AbWBQHBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 02:01:14 -0500
Received: from 203-59-85-100.dyn.iinet.net.au ([203.59.85.100]:56193 "EHLO
	eagle.themaw.net") by vger.kernel.org with ESMTP id S932533AbWBQHBM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 02:01:12 -0500
Date: Fri, 17 Feb 2006 15:00:47 +0800
Message-Id: <200602170700.k1H70lnw004000@eagle.themaw.net>
From: Ian Kent <raven@themaw.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-fsdevel@vger.kernel.org, autofs@linux.kernel.org
Subject: [RFC:PATCH 0/4] autofs4 - add direct mount functionality to autofs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are for autofs version 5.

This is the second set of patches for autofs to support the user
space daemon (automount from the autofs package) implementation of
direct mounts and lazy mount and expire of nested mount maps, such
as those found in mounting the NFS exports from a host, known as
a "hosts" map.

I'd like to thank my collegue, Jeff Moyer at RedHat for his efforts
reviewing all the autofs patches, both this set and previous patches.
His efforts have made a big difference to the quality and accuracy
of autofs in general for a long time now.

The changes implemented in the patch set are:

1) update-nameidata-on-follow_link - autofs needs the nameidata
   struct to be up to date wrt the dentry passed to the inode
   follow_link operation.
2) v5-follow_link - defines the version 5 inode follow_link
   operation used to trigger direct mounts.
3) v5-expire - update expire to handle version 5 direct mounts.
4) v5-packet-proto - update communication packet to support
   version 5 extended packet information.

Ian

