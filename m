Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265726AbSJYAPH>; Thu, 24 Oct 2002 20:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265729AbSJYAPG>; Thu, 24 Oct 2002 20:15:06 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:9811 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S265726AbSJYAPE>; Thu, 24 Oct 2002 20:15:04 -0400
Message-ID: <BD9B60A108C4D511AAA10002A50708F2073175F7@orsmsx118.jf.intel.com>
From: "Leech, Christopher" <christopher.leech@intel.com>
To: "'Jeff Garzik'" <jgarzik@pobox.com>, "H. J. Lu" <hjl@lucon.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: RE: PCI device order problem
Date: Thu, 24 Oct 2002 17:21:10 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've heard some grumbling about this with specific motherboards and 82546
LOMs. While I understand what's happening, and that using nameif to manage
this is the correct answer, I am a bit surprised that function 1 would be
placed on the global PCI device list before function 0 for a multi-function
device.

-- Chris Leech


> >>Without answering your specific question, but addressing $subject, 
> >>what
> >>problem is caused by the PCI device order you see?
> >>    
> >>
> >
> >It is different from the hardware documentation. The hardware manual 
> >says it has 2 NICs, NIC 1 (03:07.0) and NIC2 (03:07.1), which makes 
> >senses to me. NIC 1 is a special one which supports IPMI over LAN. 
> >Since we only use one NIC now, we'd like to use NIC 1 and 
> call it eth0.
> >  
> >
> 
> Well, overall, depending on ordering is error-prone (as you see).  I 
> would suggest migrating to a less-fragile scheme.  nameif and ethtool 
> together should get you exactly the device you need...  
> (though I wonder 
> why simply using eth1 is so awful, if this situation is constant...)
> 
>     Jeff
