Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261414AbVBGNGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbVBGNGF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 08:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbVBGNGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 08:06:05 -0500
Received: from alog0380.analogic.com ([208.224.222.156]:3200 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261414AbVBGNGA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 08:06:00 -0500
Date: Mon, 7 Feb 2005 08:05:56 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Justin Piszcz <jpiszcz@lucidpixels.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Reading Bad DVD Under 2.6.10 freezes the box.
In-Reply-To: <Pine.LNX.4.62.0502070728520.1743@p500>
Message-ID: <Pine.LNX.4.61.0502070757580.21063@chaos.analogic.com>
References: <Pine.LNX.4.62.0502070728520.1743@p500>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Feb 2005, Justin Piszcz wrote:

> I have a DVD where I have three files on it, (1.7gb,1.7gb,900mb).
>
> On W2K, when I try to copy the second file, I get a BadCRC error message.
>
> Under Linux, I copy up to about 860MB (watched via pipebench) and then it 
> freezes the machine, I cannot ping or get to it or do anything on the 
> console; instead, I am forced to hard reboot.
>

Okay. You need to provide linux-kernel with the kind of
CD, and the drivers installed to support it.


> Main Question >> Why does Linux 'freeze up' when W2K gives a BadCRC error msg 
> (never freezes)?

Of course it should not. However, there were many incomplete changes
made in 2.6.nn and some may involve problems with locking, etc.

For instance an ioctl() call in 2.6.10 occurs with a kernel
lock being held. A lot of CD I/O is handled using ioctl() functions.
There may be an incompatibility (called a race) with certain
things that wait in the driver when the BKL (kernel lock) is
held.

>
> The DVD FS is Joilet+ISO (hence, why none of the files are bigger than 2GB), 
> is this normal?  Or is there no checking code when there are errors on DVD's 
> to kill the read/etc so it does not freeze the box?
>
> Thanks.
> -

If possible, reboot your system with 2.4.20-or-greater and see
if the CD subsystem behaves properly with a bad CD.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
