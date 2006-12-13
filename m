Return-Path: <linux-kernel-owner+w=401wt.eu-S965074AbWLMTUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbWLMTUq (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 14:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965093AbWLMTUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 14:20:46 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:46429 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965074AbWLMTUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 14:20:45 -0500
Date: Wed, 13 Dec 2006 20:19:51 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Silviu Craciunas <silviu.craciunas@sbg.ac.at>
cc: linux-kernel@vger.kernel.org
Subject: Re: get device from file struct
In-Reply-To: <1166012939.30185.77.camel@ThinkPadCK6>
Message-ID: <Pine.LNX.4.61.0612132011280.32433@yvahk01.tjqt.qr>
References: <1165850548.30185.18.camel@ThinkPadCK6>  <457DA4A0.4060108@ens-lyon.org>
 <1165914248.30185.41.camel@ThinkPadCK6>  <Pine.LNX.4.61.0612131059100.25870@yvahk01.tjqt.qr>
  <1166006239.30185.66.camel@ThinkPadCK6>  <Pine.LNX.4.61.0612131200430.25870@yvahk01.tjqt.qr>
 <1166012939.30185.77.camel@ThinkPadCK6>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>in fs/read_write.c, the vfs_read function does:
>
>file->f_op->read(file, buf, count, pos);
>
>after this call is it possible to determine where the
>data is coming from?
>e.g., the first hard disk, a pipe or from a socket.

For hard disks:
  file->f_dentry->d_inode->d_sb->s_bdev gives you the block device
  in case it is a non-virtual filesystem.

For pipes/sockets I do not know of a may to go from a filp to a
struct sock or struct socket.

>If it is a socket we are interested
>from which device (eth0, eth1, lo, ...) the data was received.

I do not think that is possible either.


	-`J'
-- 
