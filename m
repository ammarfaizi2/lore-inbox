Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbWCHWCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWCHWCi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 17:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030220AbWCHWCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 17:02:38 -0500
Received: from ns2.suse.de ([195.135.220.15]:36280 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030216AbWCHWCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 17:02:37 -0500
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Define flush_wc, a way to flush write combining store buffers
Date: Wed, 8 Mar 2006 15:35:24 +0100
User-Agent: KMail/1.9.1
Cc: "Bryan O'Sullivan" <bos@pathscale.com>, akpm@osdl.org, paulus@samba.org,
       benh@kernel.crashing.org, bcrl@kvack.org, linux-kernel@vger.kernel.org
References: <e27c8e0061e03594b3e1.1141853501@localhost.localdomain> <1141855591.10606.12.camel@localhost.localdomain>
In-Reply-To: <1141855591.10606.12.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603081535.25515.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 March 2006 23:06, Alan Cox wrote:
> On Mer, 2006-03-08 at 13:31 -0800, Bryan O'Sullivan wrote:
> > flush_wc() says nothing about whether {A,B,C} may be reordered with
> > respect to each other, or whether {D,E} may, but it guarantees that
> > {A,B,C} will make it off-CPU before {D,E}.  An arch that implements
> > flush_wc() should make the stores occur immediately, if possible.
> 
> How is this different to mmiowb() ?

I think he intends it to be a flush instead of an ordering.
(something like CLFLUSH for WC areas)

-Andi
