Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWIUAXE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWIUAXE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWIUAXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:23:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27328 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750819AbWIUAXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:23:01 -0400
Date: Wed, 20 Sep 2006 17:22:53 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: linux-kernel@vger.kernel.org, Christoph Lameter <clameter@engr.sgi.com>
Subject: ZONE_DMA (was: Re: 2.6.19 -mm merge plans)
Message-Id: <20060920172253.f6d11445.akpm@osdl.org>
In-Reply-To: <4511D855.7050100@mbligh.org>
References: <20060920135438.d7dd362b.akpm@osdl.org>
	<4511D855.7050100@mbligh.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Subject rewritten, developer cc'ed, thwap delivered)

On Wed, 20 Sep 2006 17:09:57 -0700
"Martin J. Bligh" <mbligh@mbligh.org> wrote:

> 
> > introduce-config_zone_dma.patch
> > optional-zone_dma-in-the-vm.patch
> > optional-zone_dma-in-the-vm-tidy.patch
> > optional-zone_dma-for-i386.patch
> > optional-zone_dma-for-x86_64.patch
> > optional-zone_dma-for-ia64.patch
> > remove-zone_dma-remains-from-parisc.patch
> > remove-zone_dma-remains-from-sh-sh64.patch
> 
> Would it not make sense to define what ZONE_DMA actually means
> consistently before trying to change it? The current mess across
> different architectures seems like a disaster area to me.
> 
> What DOES requesting ZONE_DMA from a driver actually mean?
> 

AFAIK it means "floppy disks" ;)

My concern about these patches is that they'll only be useful for
self-compiled kernels, because distros will be forced to enable ZONE_DMA
for evermore anyway.

If that's correct then perhaps we should drop these patches, because they
will serve to weaken ongoing testing.
