Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290840AbSBFWHp>; Wed, 6 Feb 2002 17:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290841AbSBFWHa>; Wed, 6 Feb 2002 17:07:30 -0500
Received: from ncc1701.cistron.net ([195.64.68.38]:22280 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S290840AbSBFWHJ>; Wed, 6 Feb 2002 17:07:09 -0500
Date: Wed, 6 Feb 2002 23:06:54 +0100
From: Sander van Malssen <svm@kozmix.cistron.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.4-pre1 gameport/emu10k1 troubles
Message-ID: <20020206230654.A1048@kozmix.cistron.nl>
Mail-Followup-To: Sander van Malssen <svm@kozmix.cistron.nl>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found that in 2.5.4-pre1, my joystick (which is connected to my SB
Live gameport) doesn't seem to get recognised by the input layer.

First off, the CONFIG_INPUT_EMU10K1 gets renamed to
CONFIG_GAMEPORT_EMU10K1 in drivers/input/gameport/Makefile, but not in
.../Config.in.

Having fixed Config.in and done a make oldconfig etc., the kernel
compile seems to go all right, but when I boot from the kernel I'm still
not seeing an input device for it.

That is, where 2.5.3 said

    gameport0: Emu10k1 Gameport at 0xd000 size 8 speed 1242 kHz
    input0: Analog 2-axis 4-button joystick at gameport0.0 [TSC timer, 996 MHz clock, 834 ns res]

whereas 2.5.4-pre1 just says

    gameport0: Emu10k1 Gameport at 0xd000 size 8 speed 1242 kHz

Also, no js0 device shows up in devfs.

Relevant bits of my .config:

$ egrep 'INPUT|GAMEPORT|JOYSTICK' .config | grep =
CONFIG_INPUT=y
CONFIG_INPUT_JOYDEV=y
CONFIG_GAMEPORT=y
CONFIG_SOUND_GAMEPORT=y
CONFIG_GAMEPORT_EMU10K1=y
CONFIG_INPUT_JOYSTICK=y
CONFIG_JOYSTICK_ANALOG=y


Did I miss an option or did something go wrong with the gameport reorg?


Cheers,
Sander


-- 
Sander van Malssen -- svm@kozmix.cistron.nl -- http://www.svm.cistron.nl/
	   http://www.dragnet3.com/ -- http://www.1-2-5.net/
