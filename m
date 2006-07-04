Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbWGDQxD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbWGDQxD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 12:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWGDQxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 12:53:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:48824 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932287AbWGDQxA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 12:53:00 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [RFC 0/8] Reduce MAX_NR_ZONES and remove useless zones.
Date: Tue, 4 Jul 2006 18:52:25 +0200
User-Agent: KMail/1.9.3
Cc: Arjan van de Ven <arjan@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Con Kolivas <kernel@kolivas.org>, Marcelo Tosatti <marcelo@kvack.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>
References: <20060703215534.7566.8168.sendpatchset@schroedinger.engr.sgi.com> <1152030220.3109.73.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0607040940110.14152@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0607040940110.14152@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607041852.25575.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 July 2006 18:41, Christoph Lameter wrote:
> On Tue, 4 Jul 2006, Arjan van de Ven wrote:
> 
> > >  will need to have highmem? I guess the 2G/2G 
> > > config option changes that?
> > 
> > but that breaks userspace ABI and things that really want a lot of
> > memory ;)
> 
> Really? What things does it break? Sorry about my i386 ignorance.

There are programs who make address space assumptions for whatever reason.

When you only have 3GB it is precious space.

e.g. old Java also breaks when the AS is larger as on x86-64. That is why 
there is a  3GB personality.
> 
> > Thankfully x86-64 is there, and just about all systems sold today do 64
> > bit.. 
> 
> Right but then some binary stuff is only available for 32 bit.

That's fine - the x86-64 kernel runs 32bit programs.

-Andi

