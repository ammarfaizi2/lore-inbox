Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQLTApa>; Tue, 19 Dec 2000 19:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129703AbQLTApT>; Tue, 19 Dec 2000 19:45:19 -0500
Received: from mail18.scannet.dk ([194.255.42.18]:42512 "HELO
	mail18.scannet.dk") by vger.kernel.org with SMTP id <S129314AbQLTApE> convert rfc822-to-8bit;
	Tue, 19 Dec 2000 19:45:04 -0500
From: Jesper Juhl <juhl@eisenstein.dk>
Date: Tue, 19 Dec 2000 15:20:17 GMT
Message-ID: <20001219.15201700@jju.hyggekrogen.dk>
Subject: Strange warnings about .modinfo when compiling 2.2.18 on Alpha
To: linux-kernel@vger.kernel.org
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.2;Linux)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I just compiled 2.2.18 for my AlphaServer 400 4/233, and noticed a lot of 
messages like the following during the compile, they all contain the 
'Ignoring changed section attributes for .modinfo' part:

{standard input}: Assembler messages:
{standard input}:7: Warning: Ignoring changed section attributes for 
.modinfo
cc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -O2 
-fomit-frame-pointer -fno-strict-aliasing -pipe -mno-fp-regs -ffixed-8 
-mcpu=ev5 -Wa,-mev6 -DMODULE   -c -o nls_cp936.o nls_cp936.c


I configured the kernel with 'make menuconfig', then ran

make dep clean boot modules modules_install

The kernel boots fine and there does not seem to be any problems (at 
least not with the stuff I've tested so far). I just wanted people to 
know about this and ask if it is anything to worry about?
I'm using gcc 2.95.2 (gcc version 2.95.2 19991024 (release)) for this, 
and as far as I remember that's not the recommended compiler on Alpha 
(but it's all I have at the moment). If this is a known issue with gcc 
2.95.2, then I appologize for the inconvenience.


Best regards,
Jesper Juhl


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
