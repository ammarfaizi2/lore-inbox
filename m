Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262567AbVG2KZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262567AbVG2KZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 06:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbVG2KXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 06:23:49 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:272 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262577AbVG2KXl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 06:23:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OjDiOjpAhjdQZGefcgIAjJl8dil89qgcRho/Rty6ff2vNNTSRopRSIIZYmnqhZQ/+Dx7MPp3Lt8gKCfnsxliydYptKDsYNYv6wNCMw0lEjsPx0Jybno7DF6WcgYwjqD2sEpv2W4T5m1q1SI32rOZcG2eIGpYeWI9PbMH25lG3Tw=
Message-ID: <b115cb5f05072903233fef8dc3@mail.gmail.com>
Date: Fri, 29 Jul 2005 19:23:40 +0900
From: Rajat Jain <rajat.noida.india@gmail.com>
Reply-To: Rajat Jain <rajat.noida.india@gmail.com>
To: Rajesh Shah <rajesh.shah@intel.com>
Subject: Re: Re: Problem while inserting pciehp (PCI Express Hot-plug) driver
Cc: Kristen Accardi <kristen.kml@gmail.com>, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org,
       acpi-devel@lists.sourceforge.net,
       linux-hotplug-devel@lists.sourceforge.net, dkumar@noida.hcltech.com
In-Reply-To: <20050728175217.A1821@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050725021747.67869.qmail@web34405.mail.mud.yahoo.com>
	 <b115cb5f0507241949da02aa7@mail.gmail.com>
	 <512afbf905072711295f87ad24@mail.gmail.com>
	 <b115cb5f05072803451836055c@mail.gmail.com>
	 <20050728175217.A1821@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/05, Rajesh Shah <rajesh.shah@intel.com> wrote:
> On Thu, Jul 28, 2005 at 07:45:49PM +0900, Rajat Jain wrote:
> >
> > Okay. I'm sorry but I'm not very clear with this. I'm just putting
> > down here my understanding. So basically we have two mutually
> > EXCLUSIVE hotplug drivers I can use for PCI Express:
> >
> A hotplug slot can be controlled only by a single hotplug
> technology - pcie shpc or acpiphp. However, different parts of
> the I/O hierarchy can be controlled by different technologies.
> For example, a host bridge I/O complex can be hotplugged using
> acpiphp, but end devices under this IO complex may be hotpplugged
> using pcie or shpc hotplug.
> 
> > 1) "pciehp.ko" : We use this PCIE HP driver when our BIOS supports
> > Native Hot-plug for PCI Express (which means that hot-plug will be
> > handled by OS single handedly).
> >
> > 2) "acpiphp.ko" : We use this "generic" ACPI HP driver when BIOS
> > allows only ITSELF to handle hot-plug events.
> >
> No, acpi hotplug is not handled by BIOS only.
> Both acpi and pcie hotplug need firmware support as well as hardware
> support. Hardware in many (but not all) systems support both types of
> hotplug and its up to the BIOS to decide which type to support. If the
> platform supports pcie hotplug, you see an _OSC & _SUN methods in the
> ACPI namespace and the pciehp driver controls hotplug slots. If the
> system supports acpi hotplug, you see _ADR and _EJ0 methods in the ACPI
> namespace and the acpiphp driver controls the corresponding hotplug slots.
> 
> Rajesh
> 

Thanks a lot. It has proved to be a very useful information for me. I
can now do some R&D on it.

Thanks again,

Rajat
