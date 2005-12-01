Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbVLAM5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbVLAM5X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 07:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbVLAM5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 07:57:23 -0500
Received: from quechua.inka.de ([193.197.184.2]:2704 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932203AbVLAM5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 07:57:23 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] Filesystem like structure in RAM w/o using filesystem (not ramdisk)
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <438EE256.6040403@tuleriit.ee>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1Eho01-0007dN-00@calista.inka.de>
Date: Thu, 01 Dec 2005 13:57:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <438EE256.6040403@tuleriit.ee> you wrote:
> As I have understood the accessing ramdisk goes through the same kernel 
> path which is meant for accessing slow block device (i_nodes caching etc.).
> Is there any other common way (some API above shared memory?) to 
> create/open/read/write globally accessible hierarchical datablocks in RAM?

SYSV IPC Shared Memory?

> Could it be possibly faster than ramdisk?

I think if you mmap tmpfs files it is pretty good, which  is what libc is
doing for shm emulation.

Gruss
Bernd
