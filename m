Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVG1Ksv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVG1Ksv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 06:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261372AbVG1Kqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 06:46:36 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:35786 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261402AbVG1Kpt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 06:45:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QPuCP0B6G4QAL5NrEGJA6iEA/7hJf8Uic1qtztWfHJ3E7KP/zDG/sxSs7jm8ff+cKULN5yZuBbJXCXzUZ45Y8IF+zNSDsqY35XUdHTHvFBF6c7gpV/D5Gtw8B53phecnVnHhgjTsZMXl9nYFL6HC6S6rquytGcNKsE5+c8z45gc=
Message-ID: <b115cb5f05072803451836055c@mail.gmail.com>
Date: Thu, 28 Jul 2005 19:45:49 +0900
From: Rajat Jain <rajat.noida.india@gmail.com>
Reply-To: Rajat Jain <rajat.noida.india@gmail.com>
To: Kristen Accardi <kristen.kml@gmail.com>
Subject: Re: Re: Problem while inserting pciehp (PCI Express Hot-plug) driver
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org,
       acpi-devel@lists.sourceforge.net,
       linux-hotplug-devel@lists.sourceforge.net, dkumar@noida.hcltech.com
In-Reply-To: <512afbf905072711295f87ad24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050725021747.67869.qmail@web34405.mail.mud.yahoo.com>
	 <b115cb5f0507241949da02aa7@mail.gmail.com>
	 <512afbf905072711295f87ad24@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Hi Rajat, you can learn more about the OSHP method by reading the PCI
> express spec.  It is used to tell an ACPI bios that the OS will be
> handling the hotplug events natively.  It may be that your BIOS does
> not allow native hotplug for pcie, in which case you need to be using
> the acpiphp driver instead of the pciehp driver.  You could just try
> modprobing acpiphp and see if this will handle the hotplug events.  A
> recent version of lspci (which understands pcie) will tell you as well
> if pcie hotplug capability is supported (lspci -vv).
> 

Okay. I'm sorry but I'm not very clear with this. I'm just putting
down here my understanding. So basically we have two mutually
EXCLUSIVE hotplug drivers I can use for PCI Express:

1) "pciehp.ko" : We use this PCIE HP driver when our BIOS supports
Native Hot-plug for PCI Express (which means that hot-plug will be
handled by OS single handedly).

2) "acpiphp.ko" : We use this "generic" ACPI HP driver when BIOS
allows only ITSELF to handle hot-plug events.

Is my understanding correct? I would appreciate if you could help me
gain a grip on this.

Thanks a lot for the useful info you gave. Provided me with a new
direction to work on.

Regards,

Rajat
