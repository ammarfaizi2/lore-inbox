Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754529AbWKHLWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754529AbWKHLWm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 06:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754531AbWKHLWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 06:22:42 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:43245 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1754529AbWKHLWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 06:22:41 -0500
Message-ID: <4551BDF1.7050302@pobox.com>
Date: Wed, 08 Nov 2006 06:22:25 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Andy Whitcroft <apw@shadowen.org>, Andrew Morton <akpm@osdl.org>
CC: Greg KH <gregkh@suse.de>, Martin Bligh <mbligh@mbligh.org>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sukadev@us.ibm.com
Subject: Re: [PATCH] pci device ensure sysdata initialised v2
References: <20061020173757.GA21427@suse.de> <2026c73e8887d52443f750c2885a9f2e@pinky>
In-Reply-To: <2026c73e8887d52443f750c2885a9f2e@pinky>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft wrote:
> Ok, I've gone over the patches and retested them.  Other than having
> to extend them to cover x86_64 they still seem to work as planned.  I
> have updated the commentry to better explain the problem and the
> fix as encapsulated here.
> 
> When this was proposed last time there was push back to get the
> nodes right.  Whist this is clearly a good thing, I think we need
> this as a first step if the underlying patches are going to stay
> in.

We definitely need something like this.  Having some sysdata static and 
some sysdata dynamic makes me nervous, and so I want to review the code 
paths in depth before applying this.  My gut feeling is that there is a 
bug remaining in this area, that this patch might exacerbate.

	Jeff


