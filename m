Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262997AbRFNOOv>; Thu, 14 Jun 2001 10:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262934AbRFNOOb>; Thu, 14 Jun 2001 10:14:31 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:53390 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262800AbRFNOO3>;
	Thu, 14 Jun 2001 10:14:29 -0400
Message-ID: <3B28C6C1.3477493F@mandrakesoft.com>
Date: Thu, 14 Jun 2001 10:14:25 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Gall <tom_gall@vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Going beyond 256 PCI buses
In-Reply-To: <3B273A20.8EE88F8F@vnet.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Gall wrote:
>   The box that I'm wrestling with, has a setup where each PHB has an
> additional id, then each PHB can have up to 256 buses.  So when you are
> talking to a device, the scheme is phbid, bus, dev etc etc. Pretty easy
> really.
> 
>   I am getting for putting something like this into the kernel at large,
> it would probably be best to have a CONFIG_GREATER_THAN_256_BUSES or
> some such.

We don't need such a CONFIG_xxx at all.  The current PCI core code
should scale up just fine.

According to the PCI spec it is -impossible- to have more than 256 buses
on a single "hose", so you simply have to implement multiple hoses, just
like Alpha (and Sparc64?) already do.  That's how the hardware is forced
to implement it...

	Jeff


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
