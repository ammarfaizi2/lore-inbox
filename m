Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267935AbTB1OL5>; Fri, 28 Feb 2003 09:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267937AbTB1OL5>; Fri, 28 Feb 2003 09:11:57 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:30865
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267935AbTB1OL4>; Fri, 28 Feb 2003 09:11:56 -0500
Subject: Re: Proposal: Eliminate GFP_DMA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matthew Wilcox <willy@debian.org>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030228141234.H23865@parcelfarce.linux.theplanet.co.uk>
References: <20030228064631.G23865@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel>
	 <p73heao7ph2.fsf@amdsimf.suse.de>
	 <20030228141234.H23865@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046445897.16599.60.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 28 Feb 2003 15:24:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-28 at 14:12, Matthew Wilcox wrote:
> i'm not the kind of person who just changes the header file and breaks all
> the drivers.  plan:
> 
>  - Add the GFP_ATOMIC_DMA & GFP_KERNEL_DMA definitions
>  - Change the drivers
>  - Delete the GFP_DMA definition

Needless pain for people maintaining cross release drivers. Save it for
2.7 where we should finally do the honourable deed given x86-64 may well
be mainstream, and simply remove GFP_DMA and expect people to use 
pci_*

