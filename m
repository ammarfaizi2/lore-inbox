Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265819AbSLNTKD>; Sat, 14 Dec 2002 14:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265828AbSLNTKC>; Sat, 14 Dec 2002 14:10:02 -0500
Received: from smtp-01.inode.at ([62.99.194.3]:39571 "EHLO smtp.inode.at")
	by vger.kernel.org with ESMTP id <S265819AbSLNTKC> convert rfc822-to-8bit;
	Sat, 14 Dec 2002 14:10:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Patrick Petermair <black666@inode.at>
Reply-To: black666@inode.at
To: linux-kernel@vger.kernel.org
Subject: Re: IDE-CD and VT8235 issue!!!
Date: Sat, 14 Dec 2002 20:19:14 +0100
User-Agent: KMail/1.4.3
References: <3DFB7B21.7040004@tin.it>
In-Reply-To: <3DFB7B21.7040004@tin.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212142019.14449.black666@inode.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Same problem here. I have addressed this issue several times...so far no 
solution.

My specs:
MSI KT3 Ultra2 (VT8235)
TOSHIBA DVD-ROM SD-M1302
YAMAHA CRW8424E

Kernel 2.4.19:
The one I'm currently using. It doesn't detect the VT8235 and therefore 
I have no dma. But I can access/mount my DVD without a problem.

Kernel 2.4.20:
Detects the VT8235 at boot but hangs with my DVD Rom (hdc) --> doesn't 
boot. I have posted my problem here an Alan Cox suggested that I should 
try the -ac tree.

Kernel 2.4.20-ac2:
Some improvements - It detects the VT8235 at boot, also my DVD and CDRW. 
It boots fine and I have DMA on all my discs. But as soon as I try to 
mount a CD/DVD (mount /cdrom) the system hangs and I get this:

hdc: status timeout: status=0xd1 { Busy }
hdc: status timeout: error=0x60LastFailedSense 0x06
hdc: DMA disabled
hdc: ATAPI reset timed-out, status=0x80
hdd: DMA disabled
ide1: reset: success
hdc: status timeout: status=0x80 { Busy }
hdc: status timeout: error=0x01IllegalLengthIndication
hdc: ATAPI reset timed-out, status=0xd1
ide1: reset: success
hdc: status timeout: status=0x80 { Busy }
hdc: status timeout: error=0x01IllegalLengthIndication
end_request: I/O error, dev 16:00 (hdc), sector 0
hdc: status timeout: status=0xd0 { Busy }

and so on...

My guess is the DVD-drive. I know many people with the same southbridge 
(VT8235), who have dma since 2.4.20 an no problem at all at boot-time 
or mounting a CD/DVD.

Any hints?

Patrick

