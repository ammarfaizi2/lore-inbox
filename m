Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263174AbVGNWnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263174AbVGNWnt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 18:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbVGNWlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 18:41:45 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:37307 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262881AbVGNWjp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 18:39:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pM3clf2FVQRuCltLfwmWwckKW+RMCnduKlAs6KdcskR1tA/ZkquikCCocxKHm2GQYd+rZfOPenQwnM7ZCV/RlXAWBSjssJGKDrEednKPLx6n5b47CVeWUJJLa/o+sNp3oQ7dox/kTxk20odxY/m8mAJJ2+RPygTcopBdynmIs70=
Message-ID: <9e47339105071415392ef2eb2e@mail.gmail.com>
Date: Thu, 14 Jul 2005 18:39:43 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: [patch 2.6] remove PCI_BRIDGE_CTL_VGA handling from setup-bus.c
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20050715014611.B613@den.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050714155344.A27478@jurassic.park.msu.ru>
	 <20050714145327.B7314@flint.arm.linux.org.uk>
	 <9e47339105071407073f07bed7@mail.gmail.com>
	 <20050715014611.B613@den.park.msu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/05, Ivan Kokshaysky <ink@jurassic.park.msu.ru> wrote:
> On Thu, Jul 14, 2005 at 10:07:34AM -0400, Jon Smirl wrote:
> > I'm don't think it has ever been working in the 2.6 series. If you are
> > getting rid of it get rid of the #define PCI_BRIDGE_CTL_VGA in pci.h
> > too since this code was the only user.
> 
> No. The PCI_BRIDGE_CTL_VGA is not something artificial, it just describes
> some well defined hardware bit in the p2p bridge config header, so anyone
> working on VGA switching API will have to use it.

I had the wrong define, this is the one I was thinking of IORESOURCE_BUS_HAS_VGA

> > This code is part of VGA arbitration which BenH is addressing with a
> > more globally comprehensive patch. Ben's code will probably replace
> > it.
> 
> Yes, I've heard Ben is working on this, but I've yet to see the code. ;-)
> Any pointers?
> 
> Ivan.
> 


-- 
Jon Smirl
jonsmirl@gmail.com
