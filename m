Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbWCGVOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbWCGVOv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 16:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWCGVOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 16:14:51 -0500
Received: from mx.pathscale.com ([64.160.42.68]:53981 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932300AbWCGVOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 16:14:50 -0500
Subject: Re: [PATCH] Document Linux's memory barriers
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Andi Kleen <ak@suse.de>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200603071257.24234.ak@suse.de>
References: <200603071134.52962.ak@suse.de>
	 <7621.1141756240@warthog.cambridge.redhat.com>
	 <1141759408.2617.9.camel@serpentine.pathscale.com>
	 <200603071257.24234.ak@suse.de>
Content-Type: text/plain
Date: Tue, 07 Mar 2006 13:14:45 -0800
Message-Id: <1141766085.5255.12.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-07 at 12:57 +0100, Andi Kleen wrote:

> > > True, I suppose. I should make it clear that these accessor functions imply
> > > memory barriers, if indeed they do,
> > 
> > They don't, but according to Documentation/DocBook/deviceiobook.tmpl
> > they are performed by the compiler in the order specified.
> 
> I don't think that's correct. Probably the documentation should
> be fixed.

That's why I hedged my words with "according to ..." :-)

But on most arches those accesses do indeed seem to happen in-order.  On
i386 and x86_64, it's a natural consequence of program store ordering.
On at least some other arches, there are explicit memory barriers in the
implementation of the access macros to force this ordering to occur.

	<b

