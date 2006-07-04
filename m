Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWGDQrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWGDQrq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 12:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWGDQrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 12:47:46 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:49876 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932279AbWGDQrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 12:47:45 -0400
Subject: Re: [RFC 0/8] Reduce MAX_NR_ZONES and remove useless zones.
From: Arjan van de Ven <arjan@infradead.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Andi Kleen <ak@suse.de>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       Hugh Dickins <hugh@veritas.com>, Con Kolivas <kernel@kolivas.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
In-Reply-To: <Pine.LNX.4.64.0607040940110.14152@schroedinger.engr.sgi.com>
References: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com>
	 <20060704120242.GA3386@infradead.org>
	 <Pine.LNX.4.64.0607040806580.13456@schroedinger.engr.sgi.com>
	 <200607041723.46604.ak@suse.de>
	 <Pine.LNX.4.64.0607040915420.13795@schroedinger.engr.sgi.com>
	 <1152030220.3109.73.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0607040940110.14152@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Tue, 04 Jul 2006 18:47:42 +0200
Message-Id: <1152031662.3109.76.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-04 at 09:41 -0700, Christoph Lameter wrote:
> On Tue, 4 Jul 2006, Arjan van de Ven wrote:
> 
> > >  will need to have highmem? I guess the 2G/2G 
> > > config option changes that?
> > 
> > but that breaks userspace ABI and things that really want a lot of
> > memory ;)
> 
> Really? What things does it break? Sorry about my i386 ignorance.

things that assume you can malloc a 2gb area for example, or use a 2Gb
stack. Yes fortran apps do that..

> 
> > Thankfully x86-64 is there, and just about all systems sold today do 64
> > bit.. 
> 
> Right but then some binary stuff is only available for 32 bit.

the good news is that x86-64 has a pretty good 32 bit emulation... so
that's not an actual problem...


