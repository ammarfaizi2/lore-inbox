Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbVHDHOY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVHDHOY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 03:14:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVHDHOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 03:14:24 -0400
Received: from smtp1.belwue.de ([129.143.2.12]:10696 "EHLO smtp1.BelWue.DE")
	by vger.kernel.org with ESMTP id S261922AbVHDHOX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 03:14:23 -0400
From: Oliver Tennert <O.Tennert@science-computing.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IDE disk and HPA
Date: Thu, 4 Aug 2005 09:14:09 +0200
User-Agent: KMail/1.8.2
Cc: Oliver Tennert <O.Tennert@science-computing.de>,
       linux-kernel@vger.kernel.org
References: <200507221417.04640.tennert@science-computing.de> <1122043638.9478.14.camel@localhost.localdomain>
In-Reply-To: <1122043638.9478.14.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508040914.10810.tennert@science-computing.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 22. July 2005 16:47, Alan Cox wrote:
> > Do I interpret it right that the following is done in the above function:
>
> Aside from the version in most kernels being buggy yes
>
> > My question is now: why is an HPA disabled i.e. disprotected when
> > detected? Why not let the HPA alone, because a certain set of disk
> > sectors shall not be accessible by the OS?
>
> Because the HPA is most commonly used to hide all but a fraction of a
> disk to work with older BIOSes.

But as to my knowledge, the HPA was had been introduced to allow HW vendors to 
store things like diagnostic programs in a part of the disk protected from 
partitioning and filesystems. The point is, IF there is an HPA, there MIGHT 
be a partitioning scheme and some filesystems on the disk which rely on the 
size of disk being the native size MINUS the HPA.

Also there might be some contents in the HPA which is vulnerable to deletion 
if exposed to the OS in such a transparent way.

So unconditionally disabling the HPA seems not an unconditionally good idea to 
me.

Why is the HPA not just left alone?

Best regards

Oliver

-- 
"She said, `I know you ... you cannot sing'.  I said, `That's nothing,
you should hear me play piano.'"
		-- Morrisey
--
__
________________________________________creating IT solutions

Dr. Oliver Tennert
Senior Solutions Engineer
CAx Professional Services
                                        science + computing ag
phone   +49(0)7071 9457-598             Hagellocher Weg 71-75	
fax     +49(0)7071 9457-411             D-72070 Tuebingen, Germany
O.Tennert@science-computing.de          www.science-computing.de


