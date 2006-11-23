Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757441AbWKWRZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757441AbWKWRZx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 12:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757444AbWKWRZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 12:25:52 -0500
Received: from smtp.osdl.org ([65.172.181.25]:12681 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1757441AbWKWRZv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 12:25:51 -0500
Date: Thu, 23 Nov 2006 09:25:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] WorkStruct: Shrink work_struct by two thirds 
In-Reply-To: <10937.1164282273@redhat.com>
Message-ID: <Pine.LNX.4.64.0611230920230.27596@woody.osdl.org>
References: <20061122132008.2691bd9d.akpm@osdl.org> 
 <20061122130222.24778.62947.stgit@warthog.cambridge.redhat.com> 
 <10937.1164282273@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Nov 2006, David Howells wrote:
> 
> Of course, it all depends on whether Linus wants to take it at all...  Linus?

I think it's a cleanup, and yes, I'll take it. Not only does it shrink the 
workqueue thing, I think it's a good thing to make the timer delay option 
explicit, since it's really a totally separate feature.

I obviously didn't see how nasty the conflicts were, and I would want it 
to be not too painful for Andrew. So I could either take it early after 
2.6.19 _or_ after Andrew has merged the bulk of his stuff, depending on 
which way is easier.

I'd actually prefer to take it before -rc1, because I think the previous 
time we did something after -rc1 was a failure (the whole irq argument 
handling thing). It just exposed too many problems too late in the dev 
cycle. I'd rather have the problems be exposed by the time -rc1 rolls out, 
and keep the whole "we've done all major nasty ops by -rc1" thing)

		Linus
