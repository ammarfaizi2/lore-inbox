Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267256AbTAPUl1>; Thu, 16 Jan 2003 15:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267259AbTAPUl1>; Thu, 16 Jan 2003 15:41:27 -0500
Received: from delphin.mathe.tu-freiberg.de ([139.20.24.12]:36040 "EHLO
	delphin.mathe.tu-freiberg.de") by vger.kernel.org with ESMTP
	id <S267256AbTAPUl0> convert rfc822-to-8bit; Thu, 16 Jan 2003 15:41:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Michael Dreher <dreher@math.tu-freiberg.de>
To: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: hda has changed heads
Date: Thu, 16 Jan 2003 21:51:34 +0100
User-Agent: KMail/1.4.3
References: <200301112249.11624.dreher@math.tu-freiberg.de> <20030111221617.GA20341@win.tue.nl>
In-Reply-To: <20030111221617.GA20341@win.tue.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301162151.34206.dreher@math.tu-freiberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


Am Samstag, 11. Januar 2003 23:16 schrieb Andries Brouwer:
> On Sat, Jan 11, 2003 at 10:49:11PM +0100, Michael Dreher wrote:
> > Basically, I dont care about the new number of heads,
>
> Right
>
> > but now lilo complains like this (it did not complain before):
>
> Try giving LILO the keyword linear or lba32.
> Then it does not need any idea about the geometry at bootloader
> install time.

I tried, and it does not work. 


karpfen:/home/dreher # lilo
Added testing *
Added linux
Added failsafe
Added linux-2.5.56
Added linux-2.5.54
Device 0x0300: Invalid partition table, 2nd entry
  3D address:     1/0/20 (20160)
  Linear address: 1/12/318 (321300)

Contrary to what it prints here, lilo has added nothing.

It should write the boot sector for windows on /dev/hda5, but can not
do that because it does not understand the partition table anymore.

My box is running 2.5.56 at the moment.
I wanted to install 2.5.58. But lilo refuses to change the MBR, because 
of the number of changed heads. Even if I start it as lilo -L. 


My solution is: reboot into 2.5.54. run lilo there. reboot into 2.5.58.
Repeat for 2.5.59.

This is annoying. Any ideas how to solve this ?

Thanks,
Michael


