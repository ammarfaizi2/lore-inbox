Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310696AbSCMP6p>; Wed, 13 Mar 2002 10:58:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310699AbSCMP6f>; Wed, 13 Mar 2002 10:58:35 -0500
Received: from edge.newton.cam.ac.uk ([131.111.145.141]:63689 "EHLO
	edge.newton.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S310696AbSCMP6a>; Wed, 13 Mar 2002 10:58:30 -0500
Date: Wed, 13 Mar 2002 15:58:29 GMT
Message-Id: <200203131558.g2DFwT118218@edge.newton.cam.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: IO-APIC -- lockup on machine if enabled
In-Reply-To: <20020313083422.3262cb35.fryman@cc.gatech.edu> <20020313083422.3262cb35.fryman@cc.gatech.edu> <20020313151024.G7658@suse.de>
From: jc254@newton.cam.ac.uk (Jonathan H N Chin)
Organization: Isaac Newton Institute for Mathematical Sciences
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de> writes:
>On Wed, Mar 13, 2002 at 08:34:22AM -0500, Josh Fryman wrote:
> > i have a new laptop (Dell Latitude C610) running 2.4.18-rc4.  when i built the
> > new kernel, i thought i would amuse myself by turning on IO-APIC.

> "Don't do that"  8-)


Unfortunately, at least on my C800 here, not using it breaks IEEE1394:

    kernel: ohci1394_0: Waking dma ctx=2 ... processing is probably too slow

and communication breaks down shortly after (have to unload/reload the
modules to make it work again). On the other hand, with IO-APIC + Local
APIC enabled (APM and ACPI disabled) firewire works fine.

I note that W2K on the same machine appears to have no trouble using
both IEEE1394 and power management together. (I have booted W2K less
than ten times though versus half a year of linux use, so this may be
a false impression.)


-jonathan

-- 
Jonathan H N Chin, 1 dan | deputy computer | Newton Institute, Cambridge, UK
<jc254@newton.cam.ac.uk> | systems mangler | tel/fax: +44 1223 335986/330508

                "respondeo etsi mutabor" --Rosenstock-Huessy
