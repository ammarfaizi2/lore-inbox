Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270438AbRHSNiE>; Sun, 19 Aug 2001 09:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270433AbRHSNhz>; Sun, 19 Aug 2001 09:37:55 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:65036 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S270423AbRHSNht>; Sun, 19 Aug 2001 09:37:49 -0400
Date: Sun, 19 Aug 2001 14:38:01 +0100
From: John Levon <moz@compsoc.man.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Nasty oops with 2.4.8
Message-ID: <20010819143801.A90831@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.19i
X-Url: http://www.movement.uklinux.net/
X-Record: 0898 Dave - Brack Dragon
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got an oops yesterday just after loggin in. The machine was idle.

Unfortunately the problem trashed a number of files on the root partition, including all
traces of the (decoded) oops.

I do remember it was a pointer dereference fault in sync_unlocked_inodes(), not a NULL pointer.

The machine passes memtest86 without a hitch, has been stable with 2.4.3 and earlier for ages. ext2 /,
UP Celery 600

Interestingly during the fsck an fsck.ext2 bug was uncovered where inode_link_info was 0 but
inode.i_links.count was 1 (no, I definitely wasn't fscking a rw / ;). Perhaps that is fixed
in 1.19 though, I was using 1.18

hope this helps someone debug this rather nasty FS corruption ...

john
