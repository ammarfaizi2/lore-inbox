Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280171AbRKIVpR>; Fri, 9 Nov 2001 16:45:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280186AbRKIVpI>; Fri, 9 Nov 2001 16:45:08 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:41360 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S280171AbRKIVoy>; Fri, 9 Nov 2001 16:44:54 -0500
Message-ID: <3BEC4EAA.42A7C25@nortelnetworks.com>
Date: Fri, 09 Nov 2001 16:46:18 -0500
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: how is processor cache coherency maintained for device drivers
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm trying to help track down some infrequent and difficult to reproduce pci bus
parity errors that we're seeing on a cPCI card, and one of the things that has
been suggested is that it may have something to do with DMA coherency between
devices and the processor.

Can someone point me to the proper code/information that deals with how the
processor knows that the memory corresponding to the ethernet device is no
longer up-to-date?  Is it somehow marked as non-cacheable, or is it snooped,
explicitly flushed, or what?

The platform in question is a Motorola MCPN765 card, with a PPC7400 processor,
running a modified 2.2.17 kernel.

Thanks,

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
