Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266560AbSKLMpv>; Tue, 12 Nov 2002 07:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266555AbSKLMpv>; Tue, 12 Nov 2002 07:45:51 -0500
Received: from projecti.gemsoft.co.uk ([195.10.224.46]:6016 "EHLO r2d2.office")
	by vger.kernel.org with ESMTP id <S266560AbSKLMpu>;
	Tue, 12 Nov 2002 07:45:50 -0500
Message-ID: <3DD0F987.3050409@walrond.org>
Date: Tue, 12 Nov 2002 12:52:23 +0000
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Walrond <andrew@walrond.org>
CC: Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.44 serial driver bug with asus pr-dls m/b
References: <3DB84EAB.5020608@walrond.org> <20021103135813.B5589@flint.arm.linux.org.uk> <3DD0E95D.3090801@walrond.org> <3DD0F03F.9000604@walrond.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK;

Previously described behavior is with remote console = ENABLED in the bios.
Changing to remote console = POST ONLY in the bios, (and disabling 2nd 
serial port which doesn't have a DB9 anyway) I get

Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0: autoconf (0x03f8, 0x00000000): iir=3 iir1=6 iir2=6 type=16550A
tts/0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1: autoconf (0x02f8, 0x00000000): IER test failed (ff, ff) type=unknown
ttyS2: autoconf (0x03e8, 0x00000000): IER test failed (ff, ff) type=unknown
ttyS3: autoconf (0x02e8, 0x00000000): IER test failed (ff, ff) type=unknown

Which looks good to me. And I get some serial console output from the 
kernel as it boots, but only upto...

.
.
Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
ttyS0: autoconf (0x03f8, 0x00000000): :^

...where the serial output hangs. I presume the serial driver does 
something to the hardware which breaks the serial console output. The 
kernel does however proceed and boot normally. I'm using the kernel 
parameters
    console=ttyS0,115200n8 console=tty0

Comments?

Andrew Walrond

