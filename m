Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbVL1EKb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbVL1EKb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 23:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbVL1EKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 23:10:31 -0500
Received: from waste.org ([64.81.244.121]:52184 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932461AbVL1EKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 23:10:30 -0500
Date: Tue, 27 Dec 2005 22:07:16 -0600
From: Matt Mackall <mpm@selenic.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, hch@infradead.org
Subject: Re: [PATCH 1 of 3] Introduce __memcpy_toio32
Message-ID: <20051228040716.GB3356@waste.org>
References: <7b7b442a4d6338ae8ca7.1135726915@eng-12.pathscale.com> <adaslsec9ex.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adaslsec9ex.fsf@cisco.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2005 at 05:11:50PM -0800, Roland Dreier wrote:
> Oh yeah:
> 
>  > +EXPORT_SYMBOL_GPL(__memcpy_toio32);
> 
> I think this is a sufficiently basic facility that it might as well be
> plain EXPORT_SYMBOL(), although I don't mind making things harder on
> non-GPL modules.

This area is so murky, it verges on religion. Thus, I really think
this ought to be submitter's preference.

Any attempt to make a hard and fast rule of what's considered GPL or
not will potentially dilute any legal protection for exported symbols
predating the existence of the EXPORT_SYMBOL_GPL mechanism that are
nonetheless only reasonably used by GPL code (which by some
contributors' measures is all of them). 

In other words, we must be careful not to directly or indirectly
construe EXPORT_SYMBOL as a carte blanche for linking GPL-incompatible
code.

-- 
Mathematics is the supreme nostalgia of our time.
