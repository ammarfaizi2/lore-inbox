Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263622AbTKKRA1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 12:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbTKKRA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 12:00:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:3006 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263622AbTKKRA0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 12:00:26 -0500
Date: Tue, 11 Nov 2003 09:00:23 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Pascal Schmidt <der.eremit@email.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <E1AJbcD-0000Iw-00@neptune.local>
Message-ID: <Pine.LNX.4.44.0311110855070.30657-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Nov 2003, Pascal Schmidt wrote:
> 
> Well, that person is me and I tried making it work with ide-cd. Got read
> support to work, submitted to Jens, you have it in your kernel. No luck
> with write support. I could get it to mount read-write and data actually
> made it to disk, but umount lead to a BUG_ON.

Hmm.. That looks "impossible", so it's most likely a serious bh corruption 
issue. But what corrupts it is hard to guess at - the actual trace to that 
point has nothing to do with the MO drive itself, so you've either hit a 
generic ext2 bug (hey, it's possible, I guess, but sounds very unlikely), 
or the ide-scsi driver has corrupted memory. 

The latter is obviously the more likely schenario, but it does require 
somebody with the MO device to actually try to figure out how the 
corruption occurs.. Probably with a big printk buffer and a lot of 
printk's..

			Linus

