Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287450AbSAaA2Z>; Wed, 30 Jan 2002 19:28:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290775AbSAaA2Q>; Wed, 30 Jan 2002 19:28:16 -0500
Received: from flubber.jvb.tudelft.nl ([130.161.76.47]:36228 "EHLO
	mail.jvb.tudelft.nl") by vger.kernel.org with ESMTP
	id <S287450AbSAaA17>; Wed, 30 Jan 2002 19:27:59 -0500
From: "Robbert Kouprie" <robbert@jvb.tudelft.nl>
To: "'Stephan von Krawczynski'" <skraw@ithnet.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: NIC lockup in 2.4.17 (SMP/APIC/Intel 82557)
Date: Thu, 31 Jan 2002 01:27:47 +0100
Message-ID: <002a01c1a9ee$1b6ddd20$020da8c0@nitemare>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <20020130220659.29bd66f5.skraw@ithnet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reaction Stephan, but I seriously doubt the change below
would fix the problem... Also, as the problem appears randomly, and
usually after some uptime, I obviously can not know about it being fixed
if I constantly upgrade the kernel. I'd rather wait and see if it
appears again in time after I did a kernel upgrade, and not trying every
-pre while there's no mention on the mailing list of such bug being
fixed.

Anyway, I just rebooted with 2.4.18-pre7-ac1, we'll see if it helps.

Regards,
- Robbert


radium:/usr/src# diff -u linux.18p3-ac2/drivers/net/eepro100.c
linux.18p7-ac1/drivers/net/eepro100.c 
--- linux.18p3-ac2/drivers/net/eepro100.c       Fri Dec 21 18:41:54 2001
+++ linux.18p7-ac1/drivers/net/eepro100.c       Thu Jan 31 00:35:56 2002
@@ -28,7 +28,7 @@
 */
 
 static const char *version =
-"eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/eepro100.html\n"
+"eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.html\n"
 "eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V.
Savochkin <saw@saw.sw.com.sg> and others\n";
 
 /* A few user-configurable values that apply to all boards.


> -----Original Message-----
> From: Stephan von Krawczynski [mailto:skraw@ithnet.com] 
> Sent: woensdag 30 januari 2002 22:07
> To: Robbert Kouprie
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: NIC lockup in 2.4.17 (SMP/APIC/Intel 82557)
> 
> 
> On Wed, 30 Jan 2002 20:29:15 +0100
> "Robbert Kouprie" <robbert@jvb.tudelft.nl> wrote:
> 
> > Not much new, but still:
> > 
> > Today I got the same problem again with 2.4.18-pre3-ac2. Network
> > connections stuck, NFS mounts stuck. Bringing down/up the interface
> > doesn't help. Seems like the NIC is really in trouble here. Only a
> > reboot would bring the nick back in use.
> > 
> > Still no testcase though, and I have no idea on how to 
> investigate this
> > :(
> > Can anyone give a hint as where to seek?
> 
> How about www.kernel.org? Download _latest_ kernel-patch 
> (-pre7) and tell us
> about it. As long as you are trying only old pre's there is 
> not much of
> a chance any important brain will listen to you.
> 
> Regards,
> Stephan
> (no important brain)
> 

