Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135898AbRDVIvN>; Sun, 22 Apr 2001 04:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135938AbRDVIvD>; Sun, 22 Apr 2001 04:51:03 -0400
Received: from [164.164.83.132] ([164.164.83.132]:21257 "EHLO
	arianne.in.ishoni.com") by vger.kernel.org with ESMTP
	id <S135898AbRDVIuy>; Sun, 22 Apr 2001 04:50:54 -0400
Reply-To: <raghav@ishoni.com>
From: "Raghav P" <raghav@ishoni.com>
To: <linux-kernel@vger.kernel.org>
Subject: Question about console driver switch
Date: Sun, 22 Apr 2001 14:23:37 +0530
Message-ID: <E0FDC90A9031D511915D00C04F0CCD2503996F@leonoid.in.ishoni.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am porting a serial driver on my MIPS board and have to provide support
for serial console. After  going thru the initialisation sequence: Looks
like in the initial stages before the interrupts and memory is set up; a
serial driver is set up by some brute force method in the function
serial_console_init() and the write function address is registered to the
printk module.  After interrupts and memory are available; the old
memory(and hence the old UART driver) is freed using init_freemem() and
full-fledged UART driver is setup.

Now the doubts are:
(i) After the old serial driver is thrown out using init_freemem and new
driver is installed; register_console() is not invoked again. I tried
printing the address of the write function in printk and they remain the
same. Now how does printk start throwing out the messages using the new
driver?
(ii) Does init_freemem free both text and data? If so should care be taken
for including code before free_initmem is called?

Since I do not belong to this mailing list; It would be nice if I am replied
back to my official e-mail: raghav@ishoni.com

Thanks in advance

Raghav

_________________________________________________
P.Raghavan
ishoni Networks (India) Pvt Ltd (http://www.ishoni.com)
...Broadband for everyone
email:raghav@ishoni.com
Phone: +91-80-2292125 (Work)
Fax: +91-80-2995545 (Work)




