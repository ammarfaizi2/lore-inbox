Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312302AbSDSRFR>; Fri, 19 Apr 2002 13:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312453AbSDSRFQ>; Fri, 19 Apr 2002 13:05:16 -0400
Received: from NEVYN.RES.CMU.EDU ([128.2.145.6]:745 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id <S312302AbSDSRFP>;
	Fri, 19 Apr 2002 13:05:15 -0400
Date: Fri, 19 Apr 2002 13:05:33 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Jan Slupski <jslupski@email.com>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: [PATCH] Wrong IRQ for USB on Sony Vaio (dmi_scan.c, pci-irq.c)
Message-ID: <20020419130533.A23568@nevyn.them.org>
Mail-Followup-To: Jan Slupski <jslupski@email.com>,
	linux-kernel@vger.kernel.org, alan@redhat.com
In-Reply-To: <Pine.LNX.4.21.0204191553110.6667-100000@venus.ci.uw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2002 at 04:02:18PM +0200, Jan Slupski wrote:
> 
> Hi,
> 
> I'm writing once more about problem with IRQ assignment 
> for Sony Vaio Laptops.
> 
> Broken BIOS of these notebooks assigns IRQ 10 for USB,
> even though it is actually wired to IRQ 9.
> 
> I use PCG-FX240 model of Sony Vaio, but I have proofs of other users, 
> that exactly the same problem exists on models:
> FX200, FX220, FX250, FX270, FX290, FX370, FX503, R505JS, R505JL
> These models use Intel's 82801BA controller, and Phoenix bios.
> 
> I wrote the patch that fix this. It is written on example of
> patch for HP Pavillion (taken from 2.4.19-pre7-ac1).
> 
> This patch was tested on FX240. 
> It is build for 2.4.18-pre7-ac1.
> 
> Only problem is I don't have DMI Product names for all involved models.
> That's why I left pretty general:
>   MATCH(DMI_PRODUCT_NAME, "PCG-")

Quite some time ago (~ November) Manfred posted a cleanup patch which
fixes this in a more generic way.  You might want to ask him about it.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
