Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbTIHNYF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 09:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbTIHNYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 09:24:05 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:46301 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261901AbTIHNYA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 09:24:00 -0400
Date: Tue, 2 Sep 2003 16:37:57 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       "Brown, Len" <len.brown@intel.com>, Jeff Garzik <jgarzik@pobox.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "J.A. Magallon" <jamagallon@able.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, acpi-devel@sourceforge.net
Subject: Re: [ACPI] RE: [patch] 2.4.x ACPI updates
Message-ID: <20030902143756.GH1358@openzaurus.ucw.cz>
References: <BF1FE1855350A0479097B3A0D2A80EE009FCCA@hdsmsx402.hd.intel.com> <Pine.LNX.4.55L.0308231826470.5824@freak.distro.conectiva> <20030823223340.GA7129@hell.org.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030823223340.GA7129@hell.org.pl>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > ACPI kernel crash with 2.4.22-pre7 on ASUS L3800C
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=106146576326309&w=2
> 
> Hi,
> This is probably a BIOS / hardware bug, a rare occurence actually.
> The logs show:
> #v+
> acpi_power-0363 [64] acpi_power_transition : Error transitioning device [CFAN] to D0
> acpi_bus-0496 [63] acpi_bus_set_power    : Error transitioning device [CFAN] to D0
> acpi_thermal-0549 [62] acpi_thermal_active   : Unable to turn cooling device [c12d2528] 'on'
> Unable to handle kernel paging request at virtual address 876c33c4
> [...]
> #v-
> (sometimes there's D3 in place of D0, depending on the trip points /
> temperature readings), and then the oops follows. Unfortunately, I
> can't provide the ksymoops output, as the kernel which the oops was logged
> on has been gone long since.
> 
> Anyway, this is by no means reproducible, occurs quasi-randomly (more often

You should be able to do echo ? > /proc/acpi/*/fan/state to stress this manually...
				Pavel

-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

