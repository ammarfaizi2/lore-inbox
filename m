Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbVKJVyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbVKJVyA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 16:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbVKJVyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 16:54:00 -0500
Received: from smtp.osdl.org ([65.172.181.4]:20622 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932181AbVKJVx7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 16:53:59 -0500
Date: Thu, 10 Nov 2005 13:53:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: hugh@veritas.com, nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/15] mm: atomic64 page counts
Message-Id: <20051110135336.24d04b86.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0511101342340.16283@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.61.0511100139550.5814@goblin.wat.veritas.com>
	<Pine.LNX.4.61.0511100156320.5814@goblin.wat.veritas.com>
	<20051109181641.4b627eee.akpm@osdl.org>
	<Pine.LNX.4.61.0511100224030.6215@goblin.wat.veritas.com>
	<20051109190135.45e59298.akpm@osdl.org>
	<Pine.LNX.4.62.0511101342340.16283@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@engr.sgi.com> wrote:
>
> On Wed, 9 Nov 2005, Andrew Morton wrote:
> 
> > > I'm quite pleased with the way it's worked out, but you were intending
> > > that the 64-bit arches should get along with 32-bit counts?  Maybe.
> > 
> > That seems reasonsable for file pages.  For the ZERO_PAGE the count can do
> > whatever it wants, because we'd never free them up.
> 
> Frequent increments and decrements on the zero page count can cause a 
> bouncing cacheline that may limit performance.

I think Hugh did some instrumentation on that and decided that problems
were unlikely?
