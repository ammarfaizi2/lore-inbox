Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130989AbQKUTGA>; Tue, 21 Nov 2000 14:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131005AbQKUTFu>; Tue, 21 Nov 2000 14:05:50 -0500
Received: from pump3.york.ac.uk ([144.32.128.131]:56047 "EHLO pump3.york.ac.uk")
	by vger.kernel.org with ESMTP id <S130989AbQKUTFm>;
	Tue, 21 Nov 2000 14:05:42 -0500
Message-ID: <3A1AC075.4020506@cs.york.ac.uk>
Date: Tue, 21 Nov 2000 18:35:33 +0000
From: Michel Salim <mas118@cs.york.ac.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.13 i686; en-US; m18) Gecko/20001117
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: i82365 PCI-PCMCIA bridge still not working in 2.4.0-test11
Content-Type: multipart/mixed;
 boundary="------------040009030402010904010604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040009030402010904010604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Installed kernel 2.4.0-test11 on my Debian Woody box today. Had no 
problem apart from getting PCMCIA to work. I have a PCI-PCMCIA adapter 
on my desktop PC, using the Cirrus Logic CL6729 chipset; on a 2.2.x 
kernel it is detected as an i82365 and works accordingly.

After trying 2.4.0-test9 and -test10 (which don't support i82365), it 
was nice to see that test11-pre6 finally has regained PCMCIA support... 
so it's weird to encounter this problem. Has anyone managed to use the 
i82365 kernel module?

relevant kernel config:

PCMCIA support compiled as a module
i82365 as a module
CardBus (yenta_socket) as a module

Attached are the result of running /etc/init.d/pcmcia start and the 
error message from dmesg

Any help appreciated... and looking forward to test12... or will it be 
2.4.0-final, finally?

:)

Regards,

Michel Salim

--------------040009030402010904010604
Content-Type: text/plain;
 name="log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="log"

Starting PCMCIA services: modulesHint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
 cardmgr.

--------------040009030402010904010604
Content-Type: text/plain;
 name="errmsg"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="errmsg"

/lib/modules/2.4.0-test11/pcmcia/i82365.o: init_module: No such device
ds: no socket drivers loaded!
/lib/modules/2.4.0-test11/pcmcia/ds.o: init_module: Operation not permitted

--------------040009030402010904010604--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
