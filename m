Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265614AbSJXTm6>; Thu, 24 Oct 2002 15:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265633AbSJXTm6>; Thu, 24 Oct 2002 15:42:58 -0400
Received: from gaea.projecticarus.com ([195.10.228.71]:2993 "EHLO
	gaea.projecticarus.com") by vger.kernel.org with ESMTP
	id <S265614AbSJXTm5>; Thu, 24 Oct 2002 15:42:57 -0400
Message-ID: <3DB84EAB.5020608@walrond.org>
Date: Thu, 24 Oct 2002 20:48:59 +0100
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.44 serial driver bug with asus pr-dls m/b
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't get the serial port driver to work from with the stock linux 
kernel 2.5.44 and an asus pr-dls dual xeon m/b.

It doesn't seem to detect the uart of tts/0 at all, although it finds 
tts/1 if I enable it in the bios (there isn't a DB9 for tts/1 on the 
rear plate so I can't actually try it)

If I
    setserial /dev/tts/0 uart 16550A
which seems happy, it still doesn't work.

dmesg says...(Note this is tts/1 it sees)

Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
tts/%d1 at I/O 0x2f8 (irq = 3) is a 16550A

Bios sends POST text down serial fine, so I know the hardwares OK

PS Ultimate aim is to get serial console stuff working

Any suggestions?

