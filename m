Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291618AbSBHPpx>; Fri, 8 Feb 2002 10:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291619AbSBHPpi>; Fri, 8 Feb 2002 10:45:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:4624 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291618AbSBHPpW>; Fri, 8 Feb 2002 10:45:22 -0500
Subject: Re: [2.5.4-pre3] link error in drivers/video/video.o
To: davej@suse.de (Dave Jones)
Date: Fri, 8 Feb 2002 15:55:35 +0000 (GMT)
Cc: eike@bilbo.math.uni-mannheim.de (Rolf Eike Beer),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020208155733.F32413@suse.de> from "Dave Jones" at Feb 08, 2002 03:57:33 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ZDNA-00045D-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > drivers/video/video.o(.text.init+0x13f9): undefined reference to 
>  > `bus_to_virt_not_defined_use_pci_map'
>  > make: *** [vmlinux] Error 1
> 
>  As the variable name suggests, a driver you compiled needs to be
>  updated to use a new API.  If you're not able to tackle this

That is incorrect. The warning occurs because someone made bogus changes to
the vesa driver without understanding what was going on. The vesa frame
buffer returned by the BIOS is a physical cpu address not a bus address
and nothing to do with magic PCI mappings.

Alan
