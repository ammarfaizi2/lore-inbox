Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264887AbUE0RDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264887AbUE0RDM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 13:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264889AbUE0RDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 13:03:12 -0400
Received: from h001061b078fa.ne.client2.attbi.com ([24.91.86.110]:43396 "EHLO
	linuxfarms.com") by vger.kernel.org with ESMTP id S264887AbUE0RDE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 13:03:04 -0400
Date: Thu, 27 May 2004 13:03:24 -0400 (EDT)
From: Arthur Perry <kernel@linuxfarms.com>
X-X-Sender: kernel@tiamat.perryconsulting.net
To: Dave Jones <davej@redhat.com>
cc: amd64-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: GART error 11
In-Reply-To: <20040527150623.GP22630@redhat.com>
Message-ID: <Pine.LNX.4.58.0405271259420.18975@tiamat.perryconsulting.net>
References: <Pine.LNX.4.58.0405271023510.17982@tiamat.perryconsulting.net>
 <20040527150623.GP22630@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Dave,

I have verified that booting the system with iommu=off (with vanilla
kernel) does seem to make the problem go away.

I apologize for not being fully up to speed with knowing what relationship
the iommu has with the gart, but I will find out.

I just wanted to post my findings.

Thanks again!

Best Regards,

Arthur Perry
Lead Linux Developer / Linux Systems Architect
Validation, CSU Celestica
Sair/Linux Gnu Certified Professional
Providing professional Linux solutions for 7+ years



On Thu, 27 May 2004, Dave Jones wrote:

> On Thu, May 27, 2004 at 11:02:10AM -0400, Arthur Perry wrote:
>
>  > The question really comes down to:
>  > Is this problem an oversight of the distributors (silly! the agp driver should not be built into the kernel for server use!)
>  > or
>  > Kernel code implementation? (well, if no agp bus is present, then let's not go and set up the GART, right?)
>
> If you don't have an AGP graphics card, there'll be nothing really
> set up, unless you are using the IOMMU feature of the x86-64 kernel.
> Setting up of GART tables etc only happens when the graphics
> drivers (DRI) asks it to.
>
> Does booting with iommu=off fix this for you?
> It may be that some driver is doing something that it
> shouldn't.  If it does make the problem go away, what
> devices do you have in the system (lspci output please)
>
> 		Dave
>
