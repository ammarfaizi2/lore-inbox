Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267194AbSKXLWj>; Sun, 24 Nov 2002 06:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267200AbSKXLWj>; Sun, 24 Nov 2002 06:22:39 -0500
Received: from p0108.as-l043.contactel.cz ([194.108.242.108]:19450 "EHLO
	SnowWhite.SuSE.cz") by vger.kernel.org with ESMTP
	id <S267194AbSKXLWi> convert rfc822-to-8bit; Sun, 24 Nov 2002 06:22:38 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: PCI serial card with PCI 9052?
References: <m3smxx1aaf.fsf@Janik.cz> <20021120095618.GB319@pazke.ipt>
From: Pavel@Janik.cz (Pavel =?iso-8859-2?q?Jan=EDk?=)
X-Face: $"d&^B_IKlTHX!y2d,3;grhwjOBqOli]LV`6d]58%5'x/kBd7.MO&n3bJ@Zkf&RfBu|^qL+
 ?/Re{MpTqanXS2'~Qp'J2p^M7uM:zp[1Xq#{|C!*'&NvCC[9!|=>#qHqIhroq_S"MH8nSH+d^9*BF:
 iHiAs(t(~b#1.{w.d[=Z
Date: Sun, 24 Nov 2002 12:27:14 +0100
In-Reply-To: <20021120095618.GB319@pazke.ipt> (Andrey Panin's message of
 "Wed, 20 Nov 2002 12:56:18 +0300")
Message-ID: <m3fztrcinh.fsf@Janik.cz>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i386-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrey Panin <pazke@orbita1.ru>
   Date: Wed, 20 Nov 2002 12:56:18 +0300

Hi Andrey,

   > > I have a PCI card with two serial ports on it. It has PLX Technology
   > > PCI9052 and HOLTEK HT6552IR chips. Pictures of that card are at
   > > http://www.janik.cz/tmp/pci9052/.

[...]

   > First we need to know is it 8250 compatible. You need to make some
   > experiments with setserial to test compatibility.
   > 
   > For example:
   > setserial /dev/ttyS5 port=0xd800 irq=11
   > 
   > then try to open /dev/ttyS5 with minicom or other terminal program.

I have tried to cat /dev/ttyS5 after

setserial /dev/ttyS5 port 0xd800 irq 11

[ I tried 0xd400 and 0xd800] and everything went to

cat: /dev/ttyS5: Input/output error

So, maybe this card is not 8250 compatible :-(

The card has one region of size 128:

	Region 1: I/O ports at d400 [size=128]

I think that it is EEPROM, because there is a driver for EEPROM on this PLX
chip somewhere on the Internet (I do not have that link here).
-- 
Pavel Janík

I think I started with hitting C-h a lot.  Really a LOT.
                  -- Kai Grossjohann in gnu.emacs.help about Emacs knowledge
