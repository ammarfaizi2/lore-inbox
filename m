Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317194AbSHGKp6>; Wed, 7 Aug 2002 06:45:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317302AbSHGKp6>; Wed, 7 Aug 2002 06:45:58 -0400
Received: from dsl-213-023-062-133.arcor-ip.net ([213.23.62.133]:31751 "EHLO
	spot.local") by vger.kernel.org with ESMTP id <S317194AbSHGKp6>;
	Wed, 7 Aug 2002 06:45:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Feiler <kiza@gmx.net>
To: Brad Hards <bhards@bigpond.net.au>, Greg KH <greg@kroah.com>
Subject: Re: 2.4.19, USB_HID only works compiled in, not as module
Date: Wed, 7 Aug 2002 12:50:33 +0200
User-Agent: KMail/1.4.1
Cc: Tyler Longren <tyler@captainjack.com>, LKML <linux-kernel@vger.kernel.org>,
       vojtech@suse.cz
References: <20020805003427.7e7fc9f4.tyler@captainjack.com> <20020805165601.GA27503@kroah.com> <200208060702.29360.bhards@bigpond.net.au>
In-Reply-To: <200208060702.29360.bhards@bigpond.net.au>
X-PGP-KeyID: 0x561D4FD2
X-PGP-Key: http://www.lionking.org/~kiza/pgpkey.shtml
X-Species: Snow Leopard
X-Operating-System: Linux i686
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208071250.44353.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello all,

I have another addition to this thread. I found the same problem happening to 
my analog joystick. It's connected with a SBLive gameport. Compiling the 
driver into the kernel (or using 2.4.18 with the driver as module) gives:

gameport0: Emu10k1 Gameport at 0xd000 size 8 speed 1242 kHz
input0: Analog 3-axis 4-button joystick at gameport0.0 [TSC timer, 898 MHz 
clock, 832 ns res]

Compiling this driver as a module with 2.4.19:

analog.c: Unknown joystick device found  (data=0x2, gameport0), probably n
ot analog joystick.

So maybe the hid mouse problem is not withing the USB code, but somewhere 
else?

- -Oliver

- -- 
Oliver Feiler  <kiza@(gmx(pro).net|lionking.org|claws-and-paws.com)>
http://www.lionking.org/~kiza/  <--   homepage
PGP-key ID 0x561D4FD2    --> /pgpkey.shtml
http://www.lionking.org/~kiza/journal/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9UPuEOpifZVYdT9IRAljnAJ9HiUvxhxlMCn57GUzIMAiJuKX31ACeKDeO
UtsuM3T23F5hXUCvPGANoBE=
=3pMD
-----END PGP SIGNATURE-----

