Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVG1REi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVG1REi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 13:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbVG1RC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 13:02:56 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:32046 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261766AbVG1RAi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 13:00:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ebm1xY9ZCFP/b01BGKaYzxjlNX2a9UZ9HY5pXBuJofpHRuL4Tgh0+n5yu6nd4GEZiKiYt6HGVDWLzv6gaxwTRUeZAkgVP08xQEIVqd4ZiIfy2pqsi4XZyAfp7Ikq5XZJYiefQD5cvRl4SRjqt2msgMANdh12px9UWwqaIWGbOkg=
Message-ID: <512afbf905072810005f327e3@mail.gmail.com>
Date: Thu, 28 Jul 2005 10:00:14 -0700
From: Kristen Accardi <kristen.kml@gmail.com>
Reply-To: Kristen Accardi <kristen.kml@gmail.com>
To: Rajat Jain <rajat.noida.india@gmail.com>
Subject: Re: Re: Problem while inserting pciehp (PCI Express Hot-plug) driver
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org,
       acpi-devel@lists.sourceforge.net,
       linux-hotplug-devel@lists.sourceforge.net, dkumar@noida.hcltech.com
In-Reply-To: <b115cb5f05072803451836055c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050725021747.67869.qmail@web34405.mail.mud.yahoo.com>
	 <b115cb5f0507241949da02aa7@mail.gmail.com>
	 <512afbf905072711295f87ad24@mail.gmail.com>
	 <b115cb5f05072803451836055c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/05, Rajat Jain <rajat.noida.india@gmail.com> wrote:
> >
> > Hi Rajat, you can learn more about the OSHP method by reading the PCI
> > express spec.  It is used to tell an ACPI bios that the OS will be
> > handling the hotplug events natively.  It may be that your BIOS does
> > not allow native hotplug for pcie, in which case you need to be using
> > the acpiphp driver instead of the pciehp driver.  You could just try
> > modprobing acpiphp and see if this will handle the hotplug events.  A
> > recent version of lspci (which understands pcie) will tell you as well
> > if pcie hotplug capability is supported (lspci -vv).
> >
> 
> Okay. I'm sorry but I'm not very clear with this. I'm just putting
> down here my understanding. So basically we have two mutually
> EXCLUSIVE hotplug drivers I can use for PCI Express:
> 
> 1) "pciehp.ko" : We use this PCIE HP driver when our BIOS supports
> Native Hot-plug for PCI Express (which means that hot-plug will be
> handled by OS single handedly).
> 
> 2) "acpiphp.ko" : We use this "generic" ACPI HP driver when BIOS
> allows only ITSELF to handle hot-plug events.

usually this is configurable.  So, you can configure you BIOS to use
acpi to handle hot-plug, or you can allow the OS to handle it.  Most
OS (from what I hear) don't actually implement native hotplug support,
so native hotplug support is probably not as big a priority for bios
writers as the acpi support.  so, it doesn't surprise me to find some
that don't support native.

you can run the native hotplug driver on a system who's bios supports
acpi - if it provides the OSHP method, this tells the bios to allow
the OS to handle it.

> 
> Is my understanding correct? I would appreciate if you could help me
> gain a grip on this.

i'm trying to gain a grip myself, as i've just started learning about
pcie :).  someone else hopefully will correct me if i'm telling you
the wrong info.


> 
> Thanks a lot for the useful info you gave. Provided me with a new
> direction to work on.
> 
> Regards,
> 
> Rajat
> 

Kristen
