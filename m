Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264874AbRGSDtA>; Wed, 18 Jul 2001 23:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264932AbRGSDsu>; Wed, 18 Jul 2001 23:48:50 -0400
Received: from [216.6.80.34] ([216.6.80.34]:65040 "EHLO
	dcmtechdom.dcmtech.co.in") by vger.kernel.org with ESMTP
	id <S264874AbRGSDsn>; Wed, 18 Jul 2001 23:48:43 -0400
Message-ID: <7FADCB99FC82D41199F9000629A85D1A01C65069@dcmtechdom.dcmtech.co.in>
From: Nitin Dhingra <nitin.dhingra@dcmtech.co.in>
To: "'Rajeev Bector'" <rajeev_bector@yahoo.com>, linux-kernel@vger.kernel.org
Subject: RE: vmalloc and kiobuf questions ?
Date: Thu, 19 Jul 2001 09:19:26 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1) Yeah, vmalloc can allocate memory till the
last available ram present in your machine.

2 & 3) You can use kiobuf for locking user memory
area. They are a part of kernel 2.4.x and also if 
you have previous 2.2.x find a patch. If you have
kernel 2.4.4 +, there is a file in source 
arch/cris/drivers/examples/kiobuftest.c that is doing 
exactly what you want. You can check it out. If you 
don't have it, I also made a module for locking user 
buffers using kiobuf, if you want I can mail you the src.


Regards,
Nitin


-----Original Message-----
From: Rajeev Bector [mailto:rajeev_bector@yahoo.com]
Sent: Wednesday, July 18, 2001 11:16 PM
To: linux-kernel@vger.kernel.org
Subject: vmalloc and kiobuf questions ?


MM Gurus, 
  In trying to understand how to map driver
memory into user space memory, I have the following
questions:

1) Is there a limit to how much memory
   I can allocate using vmalloc() ?
   (This is regular RAM)
2) I want to map the vmalloc'ed memory
   to user space via mmap(). I've read
   that remap_page_range() will not do it
   and I have to do it using nopage
   handlers ? Is that true ? Is there
   a simple answer to why is that the case ?

3) I've also read the kiobufs will simplify
   all this. Is there a documentation on 
   kiobufs - what they can and cannot do ?
   Are kiobufs part of the standard kernel
   now ?
Thanks in advance for your answers !

Rajeev


__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail
http://personal.mail.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
