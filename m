Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317571AbSIIRHD>; Mon, 9 Sep 2002 13:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317580AbSIIRHD>; Mon, 9 Sep 2002 13:07:03 -0400
Received: from antigonus.hosting.pacbell.net ([216.100.98.13]:29576 "EHLO
	antigonus.hosting.pacbell.net") by vger.kernel.org with ESMTP
	id <S317571AbSIIRHC>; Mon, 9 Sep 2002 13:07:02 -0400
Reply-To: <imran.badr@cavium.com>
From: "Imran Badr" <imran.badr@cavium.com>
To: "'David S. Miller'" <davem@redhat.com>, <phillips@arcor.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Calculating kernel logical address ..
Date: Mon, 9 Sep 2002 10:06:46 -0700
Message-ID: <019d01c25823$8714c460$9e10a8c0@IMRANPC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: 
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So, what you gurus suggest me to do? How can I get physical address of a
user buffer (which was originally mmap'ed() from a kmalloc() allocation) and
which would also be protable across multiple platforms?

Thanks.
Imran.


-----Original Message-----
From: David S. Miller [mailto:davem@redhat.com]
Sent: Sunday, September 08, 2002 10:28 PM
To: phillips@arcor.de
Cc: imran.badr@cavium.com; linux-kernel@vger.kernel.org
Subject: Re: Calculating kernel logical address ..


   From: Daniel Phillips <phillips@arcor.de>
   Date: Mon, 9 Sep 2002 07:17:30 +0200

   On Monday 09 September 2002 07:00, David S. Miller wrote:
   > Actually, KSEG0 the most Linux friendly design in the world
   > particularly in 64-bit mode.

   That's easy to say until you try and work with it (I assume you have,
   and forgot).  Just try to do a 3G/1G split on it, for example.

Maybe you missed the "64-bit mode" part of what I said. :-)

In 64-bit mode there is no need to do any kind of split.
You just use the KSEG mapping with full cache coherency for
all of physical memory as the PAGE_OFFSET area.

I forget if it was KSEG0 or some other number, but I know it
works.



