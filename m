Return-Path: <linux-kernel-owner+w=401wt.eu-S1750707AbWLMU0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWLMU0T (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWLMU0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:26:19 -0500
Received: from smtp2.belwue.de ([129.143.2.15]:41808 "EHLO smtp2.belwue.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707AbWLMU0S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:26:18 -0500
X-Greylist: delayed 1529 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 15:26:18 EST
Date: Wed, 13 Dec 2006 20:59:55 +0100 (CET)
From: Karsten Weiss <K.Weiss@science-computing.de>
To: Erik Andersen <andersen@codepoet.org>
Cc: Christoph Anton Mitterer <calestyo@scientia.net>,
       linux-kernel@vger.kernel.org, Chris Wedgwood <cw@f00f.org>
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives //
 memory hole mapping related bug?!
In-Reply-To: <20061213195305.GA3358@codepoet.org>
Message-ID: <Pine.LNX.4.61.0612132056380.6688@palpatine.science-computing.de>
References: <Pine.LNX.4.64.0612021202000.2981@addx.localnet>
 <Pine.LNX.4.61.0612111001240.23470@palpatine.science-computing.de>
 <20061213195305.GA3358@codepoet.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006, Erik Andersen wrote:

> On Mon Dec 11, 2006 at 10:24:02AM +0100, Karsten Weiss wrote:
> > Last week we did some more testing with the following result:
> > 
> > We could not reproduce the data corruption anymore if we boot the machines 
> > with the kernel parameter "iommu=soft" i.e. if we use software bounce 
> > buffering instead of the hw-iommu. (As mentioned before, booting with 
> > mem=2g works fine, too, because this disables the iommu altogether.)
> > 
> > I.e. on these systems the data corruption only happens if the hw-iommu 
> > (PCI-GART) of the Opteron CPUs is in use.
> > 
> > Christoph, Erik, Chris: I would appreciate if you would test and hopefully 
> > confirm this workaround, too.
> 
> What did you set the BIOS to when testing this setting?
> Memory Hole enabled?  IOMMU enabled?

"Memory hole mapping" was set to "hardware". With "disabled" we only
see 3 of our 4 GB memory.

Best regards,
Karsten

-- 
__________________________________________creating IT solutions
Dipl.-Inf. Karsten Weiss               science + computing ag
phone:    +49 7071 9457 452            Hagellocher Weg 73
teamline: +49 7071 9457 681            72070 Tuebingen, Germany
email:    knweiss@science-computing.de www.science-computing.de

