Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266584AbSLWGQs>; Mon, 23 Dec 2002 01:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266609AbSLWGQs>; Mon, 23 Dec 2002 01:16:48 -0500
Received: from smtp002.mail.tpe.yahoo.com ([202.1.238.49]:24078 "HELO
	smtp002.mail.tpe.yahoo.com") by vger.kernel.org with SMTP
	id <S266584AbSLWGQr>; Mon, 23 Dec 2002 01:16:47 -0500
Message-ID: <001901c2aa4b$ff492cd0$3716a8c0@taipei.via.com.tw>
From: "Joseph" <jospehchan@yahoo.com.tw>
To: "David Brownell" <david-b@pacbell.net>, <linux-kernel@vger.kernel.org>
References: <3E034860.70509@pacbell.net>
Subject: Re: USB 2.0 is too slow?
Date: Mon, 23 Dec 2002 14:24:49 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You didn't mention what kernel or driver version you used.
> I'd expect more success with the latest 2.5 code, which
> should appear as a patch against 2.4.21pre soon.

Kernel 2.5.45, 2.5.51, 2.5.52 and 2.4.20 which I've tested.
Redhat 8.0, VIA VT8235 SB, Lacie USB2.0/1394 10GB HDD.

>  >   (1)Sometimes it can copy completely in 20 seconds.
>
> 300 MB, 30 seconds ... 10 MB/sec, faster can be had;
> that shouldn't tax the usb2 hardware at all.  But some
> PCI systems might not like that additional load.

Sometimes I got the messages below during copying some large data. (in
kernel 2.5.45)
   drivers/usb/core/message.c: usb_sg_cancel, unlink --> -22
   drivers/usb/core/message.c: usb_sg_cancel, unlink --> -22
   drivers/usb/core/message.c: driver for bus 00:08.2 dev 2 ep 2-in
corrupted data!
If the messages were shown, it spent more longer than 20 secs.
Although it didn't show the same messages above in kernel 2.5.52, but it
copied slowly as before.
The connection of USB2.0 devices, OS and the ehci-hcd is suspect in my test.

>  >       Is the echi-hcd module instable or immature now?
>  >       Or the VIA USB 2.0 host controller is bad support?
>
> And you need relatively recent drivers for the VIA support
> to behave, in any case.  Or even Intel; there's a timeout
> that Intel expects to be relatively long, and current kernels
> have it quite short.  We learned that just this week... :)

   Intel and I seemed to get into the same situation.  :)
   BTW, do u have any solution for  following problem.
   **If two USB2.0 devices (HDD and CD-RW) are pluged into the same usb hub,
       Two situations I met as follow. ( check /proc/scsi/scsi )
        A. 2 devices are found and can be attached.
        B. 2 devices are found but only one device can be attached.

   Thanks for your response.
BR,
  Joseph

-----------------------------------------------------------------
< ¨C¤Ñ³£ Yahoo!©_¼¯ >  www.yahoo.com.tw
