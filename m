Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261669AbSKTVtq>; Wed, 20 Nov 2002 16:49:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261678AbSKTVtq>; Wed, 20 Nov 2002 16:49:46 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:27524 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261669AbSKTVtp>; Wed, 20 Nov 2002 16:49:45 -0500
Subject: Re: Linux 2.4.20 ACPI
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       "'Ducrot Bruno'" <poup@poupinou.org>,
       Felix Seeger <seeger@sitewaerts.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <25526.1037828842@passion.cambridge.redhat.com>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A52A@orsmsx119.jf.intel.com>  
	<25526.1037828842@passion.cambridge.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Nov 2002 22:24:15 +0000
Message-Id: <1037831055.3241.97.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-20 at 21:47, David Woodhouse wrote:
> 
> andrew.grover@intel.com said:
> >  It would be great if someone could take a look at the sonypi driver
> > and see what can be done to integrate it better with ACPI. ACPI
> > includes an EC driver, so at the minimum, sonypi should use that
> > instead of poking the EC itself, perhaps. 
> 
> Surely a proper driver should always be preferred over binary-only bytecode?
> 
> The sonypi driver looks like it properly requests the regions it uses; they
> should be marked busy. Why is the ACPI code touching them?

The same microcontroller is handling both power management related
operations and also funky things like the camera. In most laptops the
microcontroller is either doing ACPI or APM so there is a convenient
split. 

I guess sonypi could take the ACPI global lock ?


