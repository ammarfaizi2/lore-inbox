Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135900AbRD3U41>; Mon, 30 Apr 2001 16:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135902AbRD3U4Q>; Mon, 30 Apr 2001 16:56:16 -0400
Received: from pop.gmx.net ([194.221.183.20]:57166 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S135900AbRD3U4E>;
	Mon, 30 Apr 2001 16:56:04 -0400
Date: Mon, 30 Apr 2001 22:55:57 +0200
From: Daniel Elstner <daniel.elstner@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: reiserfs+lndir problem [was: 2.4.4 SMP: spurious EOVERFLOW "Value too large for defined data type"]
Message-Id: <20010430225557.3f28d1b0.daniel@master.daniel.homenet>
In-Reply-To: <20010430220943.1d140e95.daniel@master.daniel.homenet>
In-Reply-To: <20010430205609.36599ccd.daniel@master.daniel.homenet>
	<20010430220943.1d140e95.daniel@master.daniel.homenet>
X-Mailer: Sylpheed version 0.4.64 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

unfortunately I have to correct me again.
The problem seems unrelated to the kernel version or SMP/UP
(though only 2.4.[34] tried yet).

Apparently it's a reiserfs/symlink problem.
I tried doing the lndir on an ext2 partition, sources still
on reiserfs. And it worked just fine!

Sorry for the rather large amount of noise, I hope it's
finally correct now :)

-- Daniel

> the problem occurs only after setting up a parallel build tree with
> lndir, removing the whole symlink tree, and running lndir again.
> Maybe an reiserfs bug?
> 
> -- Daniel
> 
> > With kernel 2.4.4 SMP, I get some spurios errors from several
> > user-space programs. Unfortunately it's hard to reproduce, I had most
> > luck with the XFree86-4.0.3 build. When doing `make World', soon cpp0
> > (called by imake) dies with the following error message:
> > 
> > cpp0: : Value too large for defined data type
> > 
> > The message seems to correspond to EOVERFLOW in gcc's libiberty.
> > When calling imake directly, it fails 1 out of 10-20 times.
> > I couldn't reproduce this with calling cpp directly.
> > 
> > I also got a lot of that messages once at shutdown,
> > as init was trying to umount /proc.
> > 
> > The error occurs neither with 2.4.3 SMP nor with 2.4.4 UP.
> > (I'm using reiserfs, too.)
> > 
> > ABIT VP6
> > dual P3 866
> > gcc version 2.95.4 20010319 (prerelease)
> > binutils 2.11
> > glibc 2.2.3
> > 
> > Could you please give me further advice how to track this down?
