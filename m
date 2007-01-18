Return-Path: <linux-kernel-owner+w=401wt.eu-S932546AbXARWAT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbXARWAT (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 17:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbXARWAT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 17:00:19 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56535 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932546AbXARWAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 17:00:17 -0500
Date: Thu, 18 Jan 2007 16:57:22 -0500 (EST)
From: Chip Coldwell <coldwell@redhat.com>
To: Andi Kleen <ak@suse.de>
cc: Chris Wedgwood <cw@f00f.org>,
       Christoph Anton Mitterer <calestyo@scientia.net>,
       Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org,
       knweiss@gmx.de, andersen@codepoet.org, krader@us.ibm.com,
       lfriedman@nvidia.com, linux-nforce-bugs@nvidia.com
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives (k8
 cpu errata needed?)
In-Reply-To: <200701180915.32944.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0701181655300.13116@localhost.localdomain>
References: <fa.E9jVXDLMKzMZNCbslzUxjMhsInE@ifi.uio.no> <200701170829.54540.ak@suse.de>
 <Pine.LNX.4.64.0701170942560.2900@localhost.localdomain> <200701180915.32944.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jan 2007, Andi Kleen wrote:
>
> The Northbridge guarantees coherency over the aperture, but
> only if the caching attributes match.

That's interesting.  Makes sense, I suppose.

> You would need to change_page_attr() every kernel address that is mapped into
> the  IOMMU to use an uncached aperture. AGP does this, but the frequency of
> mapping for the IOMMU  is much higher and it would be prohibitively costly
> unfortunately.

But it still might be a reasonable thing to do to test the theory that
the problem is cache coherency across the graphics aperture, even if
it isn't a long-term solution for the problem.

> In the past we saw corruptions from such conflicts, so this is more
> than just theory. I suspect you traded a more easy to trigger
> corruption with a more subtle one.

Yup.  That was the inspiration for the script.

Chip

-- 
Charles M. "Chip" Coldwell
Senior Software Engineer
Red Hat, Inc
978-392-2426

