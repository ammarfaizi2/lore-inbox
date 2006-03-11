Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751416AbWCKU60@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbWCKU60 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 15:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWCKU6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 15:58:25 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:55608 "EHLO
	amsfep18-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751416AbWCKU6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 15:58:25 -0500
Subject: Re: [PATCH 00/03] Unmapped: Separate unmapped and mapped pages
From: Peter Zijlstra <peter@programming.kicks-ass.net>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Magnus Damm <magnus@valinux.co.jp>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <aec7e5c30603100519l5a68aec3ub838ac69a734a46b@mail.gmail.com>
References: <20060310034412.8340.90939.sendpatchset@cherry.local>
	 <1141977139.2876.15.camel@laptopd505.fenrus.org>
	 <aec7e5c30603100519l5a68aec3ub838ac69a734a46b@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 11 Mar 2006 21:58:14 +0100
Message-Id: <1142110694.2928.6.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-10 at 14:19 +0100, Magnus Damm wrote:
> On 3/10/06, Arjan van de Ven <arjan@infradead.org> wrote:
> > > Apply on top of 2.6.16-rc5.
> > >
> > > Comments?
> >
> >
> > my big worry with a split LRU is: how do you keep fairness and balance
> > between those LRUs? This is one of the things that made the 2.4 VM suck
> > really badly, so I really wouldn't want this bad...
> 
> Yeah, I agree this is important. I think linux-2.4 tried to keep the
> LRU list lengths in a certain way (maybe 2/3 of all pages active, 1/3
> inactive). In 2.6 there is no such thing, instead the number of pages
> scanned is related to the current scanning priority.

This sounds wrong, the active and inactive lists are balanced to a 1:1
ratio. This is happens because the scan speed is directly proportional
to the size of the list. Hence the largest list will shrink fastest -
this gives a natural balance to equal sizes.

Peter


