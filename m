Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbVIIKpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbVIIKpp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 06:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbVIIKpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 06:45:44 -0400
Received: from gold.veritas.com ([143.127.12.110]:20563 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1030229AbVIIKpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 06:45:44 -0400
Date: Fri, 9 Sep 2005 11:45:27 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Jan Beulich <JBeulich@novell.com>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [discuss] [PATCH] allow CONFIG_FRAME_POINTER for x86-64
In-Reply-To: <4321749202000078000248C5@emea1-mh.id2.novell.com>
Message-ID: <Pine.LNX.4.61.0509091133180.5937@goblin.wat.veritas.com>
References: <43207D28020000780002451E@emea1-mh.id2.novell.com> 
 <200509091054.11932.ak@suse.de>  <43216EFB020000780002489B@emea1-mh.id2.novell.com>
 <200509091123.59205.ak@suse.de> <4321749202000078000248C5@emea1-mh.id2.novell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 09 Sep 2005 10:45:37.0802 (UTC) FILETIME=[9D593EA0:01C5B52B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sep 2005, Jan Beulich wrote:
> > But why would anyone want frame pointers on x86-64?
> 
> I'd put the question differently: Why should x86-64 not allow what
> other architectures do?
> 
> But of course, I'm not insisting on this patch to get in, it just
> seemed an obvious inconsistency...

I'm with Jan on this.  I use a similar patch for frame pointers on
x86_64 most of the time, in the hope of getting more accurate backtraces.

Is x86_64 somehow more likely to give you a less noisy backtrace than
i386?  Fewer of those stale return addresses from earlier trips down
the stack?

Frame pointers are imperfect on all(?) the supported architectures,
but I can't see any good reason to exclude them from x86_64.  Just a
couple of weeks ago LKML had a bug where enabling frame pointers on
x86_64 helped Ingo to pinpoint the origin of the problem.

Hugh
