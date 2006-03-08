Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWCHWH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWCHWH3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 17:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932601AbWCHWH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 17:07:29 -0500
Received: from cantor2.suse.de ([195.135.220.15]:5817 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932286AbWCHWH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 17:07:28 -0500
From: Andi Kleen <ak@suse.de>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Subject: Re: [PATCH] Define flush_wc, a way to flush write combining store buffers
Date: Wed, 8 Mar 2006 15:40:18 +0100
User-Agent: KMail/1.9.1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, akpm@osdl.org, paulus@samba.org,
       benh@kernel.crashing.org, bcrl@kvack.org, linux-kernel@vger.kernel.org
References: <e27c8e0061e03594b3e1.1141853501@localhost.localdomain> <200603081535.25515.ak@suse.de> <1141855547.27555.16.camel@localhost.localdomain>
In-Reply-To: <1141855547.27555.16.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603081540.19284.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 March 2006 23:05, Bryan O'Sullivan wrote:
> On Wed, 2006-03-08 at 15:35 +0100, Andi Kleen wrote:
> 
> > > How is this different to mmiowb() ?
> > 
> > I think he intends it to be a flush instead of an ordering.
> > (something like CLFLUSH for WC areas)
> 
> Exactly.  mmiowb guarantees ordering, but says nothing about timing.
> This would guarantee ordering, affect WC store buffers if present, and
> try to work in a timely manner.

Well if you need the flush, not the ordering then I'm not convinced
SFENCE will do that for you. My understanding is that it only guarantees
ordering. 

But at least in some earlier message you said you just needed ordering.

-Andi
