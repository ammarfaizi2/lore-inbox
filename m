Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267927AbRGWVvU>; Mon, 23 Jul 2001 17:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267931AbRGWVvK>; Mon, 23 Jul 2001 17:51:10 -0400
Received: from front7.grolier.fr ([194.158.96.57]:21953 "EHLO
	front7.grolier.fr") by vger.kernel.org with ESMTP
	id <S267927AbRGWVuy> convert rfc822-to-8bit; Mon, 23 Jul 2001 17:50:54 -0400
From: "J.L.Carlet" <pyrenees@club-internet.fr>
Reply-To: pyrenees@club-internet.fr
To: linux-kernel@vger.kernel.org
Subject: The moxa.c module is not compiled in 2.4.7 kernel.
Date: Mon, 23 Jul 2001 23:49:17 +0200
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01072323491700.00616@linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi !

I have a problem with the 2.4.7 kernel only, not with the 2.4.6.
In the 2.4.6, using make xconfig, I select Moxa Intellio support, in the 
Character devices menu. I made make dep, make clean, make modules, make 
modules_install, and then I obtained the moxa.o file in 
/lib/modules/2.4.6/kernel/drivers/char directory.
If I make the same operations with 2.4.7 kernel, I don't obtain moxa.o
The file is not compiled and not installed.
But, if I edit the file .config in /usr/src/linux with 2.4.7 kernel, I see 
the line  CONFIG_MOXA_INTELLIO=m.
I don't understand why the moxa.c file is not compiled.
I don't receive error messages.

If I want the moxa.o module, I need to make:
gcc -D__KERNEL__ -I/usr/src/linux-2.4.7/include -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i686 -malign-functions=4  -DMODULE  
 -DEXPORT_SYMTAB -c moxa.c
and then I have to copy moxa.o in the /lib/modules/2.4.7/kernel/drivers/char 
directory.

The computer is an i386 , Duron processor
The multiport card is an Intellio Moxa C218 ISA card
The distribution is Suse 7

Thank you for your response.

Best regards.

