Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTHWWdY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 18:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbTHWWdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 18:33:24 -0400
Received: from hell.org.pl ([212.244.218.42]:52242 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S263452AbTHWWdU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 18:33:20 -0400
Date: Sun, 24 Aug 2003 00:33:40 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: "Brown, Len" <len.brown@intel.com>, Jeff Garzik <jgarzik@pobox.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       "J.A. Magallon" <jamagallon@able.es>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, acpi-devel@sourceforge.net
Subject: Re: [ACPI] RE: [patch] 2.4.x ACPI updates
Message-ID: <20030823223340.GA7129@hell.org.pl>
References: <BF1FE1855350A0479097B3A0D2A80EE009FCCA@hdsmsx402.hd.intel.com> <Pine.LNX.4.55L.0308231826470.5824@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0308231826470.5824@freak.distro.conectiva>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Marcelo Tosatti:
> ACPI kernel crash with 2.4.22-pre7 on ASUS L3800C
> http://marc.theaimsgroup.com/?l=linux-kernel&m=106146576326309&w=2

Hi,
This is probably a BIOS / hardware bug, a rare occurence actually.
The logs show:
#v+
acpi_power-0363 [64] acpi_power_transition : Error transitioning device [CFAN] to D0
acpi_bus-0496 [63] acpi_bus_set_power    : Error transitioning device [CFAN] to D0
acpi_thermal-0549 [62] acpi_thermal_active   : Unable to turn cooling device [c12d2528] 'on'
Unable to handle kernel paging request at virtual address 876c33c4
[...]
#v-
(sometimes there's D3 in place of D0, depending on the trip points /
temperature readings), and then the oops follows. Unfortunately, I
can't provide the ksymoops output, as the kernel which the oops was logged
on has been gone long since.

Anyway, this is by no means reproducible, occurs quasi-randomly (more often
when the machine is cold, possibly due to the fact that actual state
transitions take place then), and causes various effects from keventd /
ACPI subsystem locking to system hangs.
Hope that helps, best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
