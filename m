Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030355AbWBHQ2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030355AbWBHQ2e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 11:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030364AbWBHQ2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 11:28:34 -0500
Received: from cantor2.suse.de ([195.135.220.15]:41136 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030355AbWBHQ2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 11:28:33 -0500
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes 2.6.16-rc1[2] on 2 node X86_64
Date: Wed, 8 Feb 2006 17:27:31 +0100
User-Agent: KMail/1.8.2
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       Bharata B Rao <bharata@in.ibm.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>, linux-kernel@vger.kernel.org
References: <20060205163618.GB21972@in.ibm.com> <200602081706.26853.ak@suse.de> <Pine.LNX.4.62.0602080816560.2289@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.62.0602080816560.2289@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602081727.31850.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 February 2006 17:20, Christoph Lameter wrote:
> On Wed, 8 Feb 2006, Andi Kleen wrote:
> 
> > > So a provisional solution would be to simply ignore empty zones in 
> > > bind_zonelist?
> > 
> > That would likely prevent the crash yes (Bharata can you test?)
> > 
> > But of course it still has the problem of a lot of memory being unpolicied
> > on machines with >4GB if there's both DMA32 and NORMAL.
> 
> The fix could result in a zonelist with no zones. So we can answer one 
> question in __alloc_pages().

I don't think it can happen - at least one zone <= policy-zone has to 
have memory otherwise the machine wouldn't work at all.

-Andi
