Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263078AbRFNPRd>; Thu, 14 Jun 2001 11:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263084AbRFNPRX>; Thu, 14 Jun 2001 11:17:23 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:27791 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S263078AbRFNPRI>;
	Thu, 14 Jun 2001 11:17:08 -0400
Message-ID: <3B28D570.F757DEF8@mandrakesoft.com>
Date: Thu, 14 Jun 2001 11:17:04 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jonathan Lundell <jlundell@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Going beyond 256 PCI buses
In-Reply-To: <3B273A20.8EE88F8F@vnet.ibm.com>
	 <3B28C6C1.3477493F@mandrakesoft.com> <p05100306b74e83f6860f@[207.213.214.37]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Lundell wrote:
> 
> At 10:14 AM -0400 2001-06-14, Jeff Garzik wrote:
> >According to the PCI spec it is -impossible- to have more than 256 buses
> >on a single "hose", so you simply have to implement multiple hoses, just
> >like Alpha (and Sparc64?) already do.  That's how the hardware is forced
> >to implement it...
> 
> That's right, of course. A small problem is that dev->slot_name
> becomes ambiguous, since it doesn't have any hose identification. Nor
> does it have any room for the hose id; it's fixed at 8 chars, and
> fully used (bb:dd.f\0).

Ouch.  Good point.  Well, extending that field's size shouldn't break
anything except binary modules (which IMHO means, it doesn't break
anything).

	Jeff


-- 
Jeff Garzik      | Andre the Giant has a posse.
Building 1024    |
MandrakeSoft     |
