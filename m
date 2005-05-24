Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261346AbVEXDUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVEXDUv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 23:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVEXDUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 23:20:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:12499 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261324AbVEXDUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 23:20:38 -0400
Date: Mon, 23 May 2005 23:20:26 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Herbert Xu <herbert@gondor.apana.org.au>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-crypto@vger.kernel.org>, <davem@davemloft.net>
Subject: Re: [CRYPTO]: Only reschedule if !in_atomic()
In-Reply-To: <20050524024318.GB29242@gondor.apana.org.au>
Message-ID: <Xine.LNX.4.44.0505232319450.1507-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 May 2005, Herbert Xu wrote:

> On Mon, May 23, 2005 at 07:31:16PM -0700, Andrew Morton wrote:
> > 
> > Are you sure it's actually needed? Have significant scheduling latencies
> > actually been observed?
> 
> I certainly don't have any problems with removing the yield altogether.
> 
> > Bear in mind that anyone who cares a lot about latency will be running
> > CONFIG_PREEMPT kernels, in which case the whole thing is redundant anyway. 
> > I generally take the position that if we're going to put a scheduling point
> > into a non-premept kernel then it'd better be for a pretty bad latency
> > point - more than 10 milliseconds, say.
> 
> The crypt() function can easily take more than 10 milliseconds with
> a large enough buffer.
> 
> James & Dave, do you have any opinions on this?

a) remove the scheudling point and see if anyone complains
b) if so, add a flag



- James
-- 
James Morris
<jmorris@redhat.com>


