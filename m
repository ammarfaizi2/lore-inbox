Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264877AbRGJJ5a>; Tue, 10 Jul 2001 05:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265042AbRGJJ5V>; Tue, 10 Jul 2001 05:57:21 -0400
Received: from core-gateway-1.hyperlink.com ([213.219.35.163]:29964 "EHLO
	core-gateway-1.hyperlink.com") by vger.kernel.org with ESMTP
	id <S264877AbRGJJ5I>; Tue, 10 Jul 2001 05:57:08 -0400
To: linux-kernel@vger.kernel.org
Subject: es1370/1371 compilation clash
Message-ID: <994759043.3b4ad183f0364@extranet.jtrix.com>
Date: Tue, 10 Jul 2001 10:57:23 +0100 (BST)
From: "Martin A. Brooks" <martin.brooks@hyperlink.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.5
X-Originating-IP: 10.119.8.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I know this isn't really a valid combination however using 2.4.6ac2 and
selecting both es1370 and es1371 gives this...

ld -m elf_i386  -r -o sounddrivers.o soundcore.o es1370.o es1371.o ac97_codec.o
es1371.o: In function `gameport_register_port':
es1371.o(.text+0x587c): multiple definition of `gameport_register_port'
es1370.o(.text+0x5670): first defined here
es1371.o: In function `gameport_unregister_port':
es1371.o(.text+0x5880): multiple definition of `gameport_unregister_port'
es1370.o(.text+0x5674): first defined here
make[3]: *** [sounddrivers.o] Error 1

Arguably someone could have both chipsets in the same box, though.

Regards

Martin A. Brooks,  Systems Administrator
-------------------------------------------
Hyperlink Plc		t: +44 207 395 4980
57-59 Neal Street	f: +44 207 395 4981
Covent Garden		e: martin@hyperlink.com
London WC2H 9PJ		w: http://www.hyperlink.com
