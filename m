Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135245AbRD3N7H>; Mon, 30 Apr 2001 09:59:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135246AbRD3N66>; Mon, 30 Apr 2001 09:58:58 -0400
Received: from dutidad.twi.tudelft.nl ([130.161.158.199]:21132 "EHLO dutidad")
	by vger.kernel.org with ESMTP id <S135245AbRD3N6q>;
	Mon, 30 Apr 2001 09:58:46 -0400
Date: Mon, 30 Apr 2001 15:58:44 +0200
From: "Charl P. Botha" <c.p.botha@its.tudelft.nl>
To: kiza@gmx.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: pci/quirks.c - VIA PCI latency in 2.4.4
Message-ID: <20010430155844.E8052@dutidad.twi.tudelft.nl>
Reply-To: "Charl P. Botha" <c.p.botha@its.tudelft.nl>
In-Reply-To: <20010430154852.D8052@dutidad.twi.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010430154852.D8052@dutidad.twi.tudelft.nl>; from c.p.botha@its.tudelft.nl on Mon, Apr 30, 2001 at 03:48:52PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I should probably clarify.  The fix is *only* valid for the VIA VT8363 host to
pci bridge, therefore the test for the 686B south bridge only gets done if a
8363 is found.  

No fix is known for intel pci-to-host bridges with the 686B south bridge,
and in the case of the AMD-761 chipset, there are certain BIOS settings you
can change.  See: http://home.tiscalinet.de/au-ja/review-kt133a-4-en.html

On Mon, Apr 30, 2001 at 03:48:52PM +0200, Charl P. Botha wrote:
> You're right, this is a problem, your solution is not entirely correct
> though (the south bridge has to be checked, but the patch is to the config
> registers of the pci-host bridge).  Please see my patch posted on this list
> with subject "Re: 2.4.4 Sound corruption [PATCH] NEW, ignore previous
> patch".

-- 
charl p. botha      | computer graphics and cad/cam 
http://cpbotha.net/ | http://www.cg.its.tudelft.nl/
