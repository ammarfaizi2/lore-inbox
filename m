Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbSKTWBK>; Wed, 20 Nov 2002 17:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbSKTWBH>; Wed, 20 Nov 2002 17:01:07 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:30852 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261836AbSKTWA2>; Wed, 20 Nov 2002 17:00:28 -0500
Subject: Re: Linux 2.4.20 ACPI
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       "'Ducrot Bruno'" <poup@poupinou.org>,
       Felix Seeger <seeger@sitewaerts.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <25766.1037829570@passion.cambridge.redhat.com>
References: <1037831055.3241.97.camel@irongate.swansea.linux.org.uk> 
	<EDC461A30AC4D511ADE10002A5072CAD04C7A52A@orsmsx119.jf.intel.com>
	<25526.1037828842@passion.cambridge.redhat.com>  
	<25766.1037829570@passion.cambridge.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Nov 2002 22:34:56 +0000
Message-Id: <1037831696.3702.102.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-20 at 21:59, David Woodhouse wrote:
> 
> alan@lxorguk.ukuu.org.uk said:
> >  I guess sonypi could take the ACPI global lock ?
> 
> I assume that's not a serious suggestion. Perhaps it could release the 
> region while it's not _actually_ using it, and the ACPI code could be fixed 
> to not touch regions which it doesn't own.

It isnt about regions. The microcontroller talks a message protocol,
much the same actually as most power microcontroller seem to do. Its
just Sony also added other stuff to the protocol.

Taking the acpi lock looks like its a generic way to deal with this
situation. Its made more important because a few sony laptops actually
require ACPI to do pci/irq setup

