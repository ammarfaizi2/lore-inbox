Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932611AbWCXMvf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbWCXMvf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 07:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932619AbWCXMve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 07:51:34 -0500
Received: from mx1.suse.de ([195.135.220.2]:19626 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932611AbWCXMve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 07:51:34 -0500
From: Andi Kleen <ak@suse.de>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] use select for GART_IOMMU to enable AGP
Date: Fri, 24 Mar 2006 13:51:28 +0100
User-Agent: KMail/1.9.1
Cc: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20060323014046.2ca1d9df.akpm@osdl.org> <p73odzw59ct.fsf@verdi.suse.de> <Pine.LNX.4.64.0603241335140.16802@scrub.home>
In-Reply-To: <Pine.LNX.4.64.0603241335140.16802@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603241351.29195.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 March 2006 13:45, Roman Zippel wrote:
> Hi,
> 
> On Fri, 24 Mar 2006, Andi Kleen wrote:
> 
> > > The easiest solution is to simply remove the default and let GART_IOMMU 
> > > select AGP too.
> > 
> > GART_IOMMU works without AGP driver too. It just has the requirement
> > that the AMD64 AGP driver is either builtin or not enabled at all.
> 
> I don't see how this is/was possible, if GART_IOMMU was enabled so was AGP 
> (and AGP_AMD64). That hasn't changed with the patch.

That was/is a bug that was originally introduced in the 2.4->2.6 Kconfig conversion.
The code was designed to handle it and did in 2.4.

-Andi
