Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290864AbSARXDR>; Fri, 18 Jan 2002 18:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290863AbSARXDI>; Fri, 18 Jan 2002 18:03:08 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:34250 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S290864AbSARXC7>; Fri, 18 Jan 2002 18:02:59 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [PATCH] IBM Lanstreamer bugfixes
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF0DC8C676.D07D3CD8-ON85256B45.007E1B7C@raleigh.ibm.com>
From: "Kent E Yoder" <yoder1@us.ibm.com>
Date: Fri, 18 Jan 2002 17:02:57 -0600
X-MIMETrack: Serialize by Router on D04NM109/04/M/IBM(Release 5.0.9 |November 16, 2001) at
 01/18/2002 06:02:58 PM,
	Serialize complete at 01/18/2002 06:02:58 PM
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>>   For #6, the udelay(1) had more to do with the following write() than 
>> with spin_lock().  When that delay was not there, the write failed 
>> randomly. The same with the udelay(10) at the end of the interrupt 
>> function...
>
>That smells of covering up a race rather than fixing something. Another
>thing you may be doing perhaps is hiding PCI posting effects ?

  Ok, I thought of one thing that might make things clearer here: when I 
say "the write failed", I mean that we saw the write go out on the PCI bus 
and then the box locked up.  We were looking at it on a PCI bus analyzer. 
That, and it wasn't just this write, or just writes in general, it really 
seemed random.

  BTW, I don't know what PCI posting effects are...

Kent


