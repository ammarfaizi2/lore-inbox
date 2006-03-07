Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWCGTYk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWCGTYk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 14:24:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbWCGTYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 14:24:40 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59802 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932237AbWCGTYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 14:24:38 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <200603071213.47885.ak@suse.de> 
References: <200603071213.47885.ak@suse.de>  <200603071134.52962.ak@suse.de> <31492.1141753245@warthog.cambridge.redhat.com> <7621.1141756240@warthog.cambridge.redhat.com> 
To: Andi Kleen <ak@suse.de>, Stephen Hemminger <shemminger@osdl.org>,
       Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Tue, 07 Mar 2006 19:24:03 +0000
Message-ID: <8620.1141759443@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:

> > > You're not supposed to do it this way anyways. The official way to access
> > > MMIO space is using read/write[bwlq]
> > 
> > True, I suppose. I should make it clear that these accessor functions imply
> > memory barriers, if indeed they do, 
> 
> I don't think they do.

Hmmm.. Seems Stephen Hemminger disagrees:

| > > 1) Access to i/o mapped memory does not need memory barriers.
| > 
| > There's no guarantee of that. On FRV you have to insert barriers as
| > appropriate when you're accessing I/O mapped memory if ordering is required
| > (accessing an ethernet card vs accessing a frame buffer), but support for
| > inserting the appropriate barriers is built into gcc - which knows the rules
| > for when to insert them.
| > 
| > Or are you referring to the fact that this should be implicit in inX(),
| > outX(), readX(), writeX() and similar?
| 
| yes

David
