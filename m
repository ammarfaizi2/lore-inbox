Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265947AbTCEMhy>; Wed, 5 Mar 2003 07:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266069AbTCEMhy>; Wed, 5 Mar 2003 07:37:54 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:50594
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265947AbTCEMhw>; Wed, 5 Mar 2003 07:37:52 -0500
Subject: Re: Proposal: Eliminate GFP_DMA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Matthew Wilcox <willy@debian.org>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030305084332.B22193@bitwizard.nl>
References: <20030228064631.G23865@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel>
	 <p73heao7ph2.fsf@amdsimf.suse.de>
	 <20030228141234.H23865@parcelfarce.linux.theplanet.co.uk>
	 <1046445897.16599.60.camel@irongate.swansea.linux.org.uk>
	 <20030228143405.I23865@parcelfarce.linux.theplanet.co.uk>
	 <1046447737.16599.83.camel@irongate.swansea.linux.org.uk>
	 <20030304185616.A9527@bitwizard.nl>
	 <1046819369.12226.34.camel@irongate.swansea.linux.org.uk>
	 <20030305084332.B22193@bitwizard.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046872389.14167.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 05 Mar 2003 13:53:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-05 at 07:43, Rogier Wolff wrote:
> PCI devices on the restricted PCI bus (dev2) will have to pass a 
> memory allocation descriptor that describes just the memory on 
> that PCI bus,  the other one (dev1) can pass a descriptor that 
> prefers the non-shared memory, (leaving as much as possible for 
> the devices on the other bus (bus2)), but
> reverts to the memory that the other devices can handle as well. 

Which is actually what I said - you need to have the pci_alloc 
equivalents for generic devices and pass the device you wish to
do the allocation for. How that allocation occurs doesn't 
matter too much and can be arch specific

