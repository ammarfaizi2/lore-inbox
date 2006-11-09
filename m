Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424205AbWKIWfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424205AbWKIWfj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 17:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424206AbWKIWfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 17:35:38 -0500
Received: from gate.crashing.org ([63.228.1.57]:2495 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1424205AbWKIWfh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 17:35:37 -0500
Subject: Re: [PATCH 0/2] Add dev_sysdata and use it for ACPI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <20061109170435.07d2e0c4@gondolin.boeblingen.de.ibm.com>
References: <1163033121.28571.792.camel@localhost.localdomain>
	 <20061109170435.07d2e0c4@gondolin.boeblingen.de.ibm.com>
Content-Type: text/plain
Date: Fri, 10 Nov 2006 09:35:37 +1100
Message-Id: <1163111737.4982.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-09 at 17:04 +0100, Cornelia Huck wrote:
> On Thu, 09 Nov 2006 11:45:21 +1100,
> Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:
> 
> >  - Add a dev_sysdata structure to struct device whose content is arch
> > specific. It will allow architectures like powerpc, arm, i386, ... who
> > need different types of DMA ops for busses and other kind of auxilliary
> > data for devices in general (numa node id, firmware data, etc...) to put
> > them in there, without bloating all architectures. The patch adds an
> > empty definition for the structure to all architectures.
> 
> I like this. If we could move the dma stuff in there, we could get rid
> of it on s390 where it is just bloat we drag around...
> 
> (Maybe dev_archdata would be a better name, since the definition is
> architecture specific?)

Hrm... I wonder why I posted from my IBM address :-) I have no firm
preference on the name of the structure. So far, I had no feedback on
that patch at all appart from yours though.

Andrew, Greg ? Is that something you would take for 2.6.20 ? I need to
know wether I should rework my patches to use that or stick to my hacks
involving hijacking firmware_data.

Cheers,
Ben.

