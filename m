Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264456AbSIVSeq>; Sun, 22 Sep 2002 14:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264457AbSIVSeq>; Sun, 22 Sep 2002 14:34:46 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:3200 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S264456AbSIVSep>;
	Sun, 22 Sep 2002 14:34:45 -0400
Date: Sun, 22 Sep 2002 13:37:55 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.37 broke the floppy driver
In-Reply-To: <200209212301.BAA08451@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.44.0209221334170.829-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Sep 2002, Mikael Pettersson wrote:

> With 2.5.37, doing a write to floppy makes the kernel print
> "blk: request botched" and a few seconds later instantly reboot
> the machine (w/o any further messages). 2.5.36 works fine.
> 
> "dd bs=8k if=bzImage of=/dev/fd0" triggers this every time.

I duplicated this on 2.5.37-bk as well as 2.5.38-bk.  Maybe we have an 
off-by-one error?  I see the following under 2.5.38-bk:

[tmolina@dad boot]$ dd if=bzImage of=/dev/fd0
dd: writing to `/dev/fd0': No space left on device
5+0 records in
4+0 records out

If I repeate the command I get lines of the 
blk: request botched messages with the following flashed briefly on the 
screen (I wouldn't have seen it if I weren't looking for it):

dd: writing to `/dev/fd0': No space left on device
1441+0 records in
1440+0 records out


