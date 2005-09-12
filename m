Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbVILGtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbVILGtD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 02:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbVILGtD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 02:49:03 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:27071
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750921AbVILGtB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 02:49:01 -0400
Message-Id: <4325412D0200007800024DE1@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Mon, 12 Sep 2005 08:49:49 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rmmod notifier chain
References: <43206EFE0200007800024451@emea1-mh.id2.novell.com> <20050908151624.GA11067@infradead.org> <432073610200007800024489@emea1-mh.id2.novell.com> <20050908184659.6aa5a136.akpm@osdl.org> <43219FDF0200007800024975@emea1-mh.id2.novell.com> <20050909112721.316f2dbb.akpm@osdl.org>
In-Reply-To: <20050909112721.316f2dbb.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I cherrypicked five of your patches yesterday as ones which look like
they
>should be in 2.6.14.
>
>	fix i386 cmpxchg
>	adjust .version updating
>	free initrd mem adjustment
>	constify font data
>	minor fbcon_scroll adjustment
>
>But none of those are NMI-related.  Specifically which patch are you
>referring to?

http://marc.theaimsgroup.com/?l=linux-kernel&m=112600003916210&w=2

>...

>>  I'd be curious to know how you, considering yourself in my
position,
>>  would have approached breaking up and submitting that size a
patch.
>
>a) Patches which affect the main kernel but which aren't really
>   debugger-related

So it was right to start with those...

>b) Patches which affect the main kernel and which are
debugger-related
>   (adding hooks, generalising interfaces, refactoring functions,
etc).

... and some of those. But you saying this was more or less the right
approach puts things in contradiction with the complaints from others
that consumers of some of the changes weren't immediately visible.

>c) Finally, one monster patch to add the debugger functionality. 
Maybe
>   split into in vger-sized chunks.

That'll have to follow later.

Thanks, Jan
