Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWBLNkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWBLNkT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 08:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWBLNkT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 08:40:19 -0500
Received: from 203-59-200-129.dyn.iinet.net.au ([203.59.200.129]:26074 "EHLO
	eagle.themaw.net") by vger.kernel.org with ESMTP id S1750732AbWBLNkS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 08:40:18 -0500
Date: Sun, 12 Feb 2006 21:40:06 +0800
Message-Id: <200602121340.k1CDe67s019267@eagle.themaw.net>
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

Comments and suggstions please.

