Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267123AbTALPA1>; Sun, 12 Jan 2003 10:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267125AbTALPA0>; Sun, 12 Jan 2003 10:00:26 -0500
Received: from delphin.mathe.tu-freiberg.de ([139.20.24.12]:48041 "EHLO
	delphin.mathe.tu-freiberg.de") by vger.kernel.org with ESMTP
	id <S267123AbTALPAY> convert rfc822-to-8bit; Sun, 12 Jan 2003 10:00:24 -0500
Content-Type: text/plain; charset=US-ASCII
From: Michael Dreher <dreher@math.tu-freiberg.de>
To: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: hda has changed heads
Date: Sun, 12 Jan 2003 16:10:13 +0100
User-Agent: KMail/1.4.3
References: <200301112249.11624.dreher@math.tu-freiberg.de> <20030111221617.GA20341@win.tue.nl>
In-Reply-To: <20030111221617.GA20341@win.tue.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301121610.13989.dreher@math.tu-freiberg.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 11. Januar 2003 23:16 schrieben Sie:
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

I did already:

karpfen:/home/dreher # more /etc/lilo.conf
boot    = /dev/hda
change-rules
reset
read-only
menu-scheme = Wg:kw:Wg:Wg
lba32
prompt
timeout = 80
message = /boot/message

  image  = /boot/bzImage
  label  = testing
  root   = /dev/hda3
  vga    = 791
......

Will try with "linear" next.

Michael


