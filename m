Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264896AbRF3JsI>; Sat, 30 Jun 2001 05:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264900AbRF3Jr7>; Sat, 30 Jun 2001 05:47:59 -0400
Received: from dutidad.twi.tudelft.nl ([130.161.158.199]:38060 "EHLO dutidad")
	by vger.kernel.org with ESMTP id <S264896AbRF3Jro>;
	Sat, 30 Jun 2001 05:47:44 -0400
Date: Sat, 30 Jun 2001 11:47:35 +0200
From: "Charl P. Botha" <c.p.botha@its.tudelft.nl>
To: Jeff S Wheeler <jsw@five-elements.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA 82C686B SouthBridge fixup in linux/drivers/pci/quirks.c
Message-ID: <20010630114735.A4311@dutidad.twi.tudelft.nl>
In-Reply-To: <NEBBJNLLGLPLEJAFGEPEEEFLCBAA.jsw@five-elements.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <NEBBJNLLGLPLEJAFGEPEEEFLCBAA.jsw@five-elements.com>; from jsw@five-elements.com on Fri, Jun 29, 2001 at 09:44:51PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2001 at 09:44:51PM -0400, Jeff S Wheeler wrote:
> The VIA686B SouthBridge bug workaround is not activated on motherboards
> which have a VIA 82C686B that needs fixing, but not a VIA NorthBridge.  For

> Below is a patch to the __initdata table which causes the fix to be applied
> based on detection of the buggy SouthBridge, and *not* the NorthBridge which
> is commonly used with it.  This is the correct behavior, and was suggested
> by someone during the thread I reference, however this aspect of the fix was

No, this is NOT correct behaviour.  Please read the pages at:
http://home.tiscalinet.de/au-ja/review-kt133a-1-en.html (and especially
click on "Bugfix for everybody"); this URL is in the code.  You will note
that it is explicitly stated that this fix is NOT meant for any other
Northbridge than VIA.  So, in short, if there is no BIOS update available
for your board, you're going to have to some more research.  The PCI
registers that are configured could have a totally different (and even
dangerous) effect on your configuration.

-- 
charl p. botha      | computer graphics and cad/cam 
http://cpbotha.net/ | http://www.cg.its.tudelft.nl/
