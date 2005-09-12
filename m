Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751191AbVILHKp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbVILHKp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 03:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbVILHKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 03:10:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2794 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751193AbVILHKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 03:10:43 -0400
Date: Mon, 12 Sep 2005 00:10:15 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Jan Beulich" <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rmmod notifier chain
Message-Id: <20050912001015.1a8296c7.akpm@osdl.org>
In-Reply-To: <4325412D0200007800024DE1@emea1-mh.id2.novell.com>
References: <43206EFE0200007800024451@emea1-mh.id2.novell.com>
	<20050908151624.GA11067@infradead.org>
	<432073610200007800024489@emea1-mh.id2.novell.com>
	<20050908184659.6aa5a136.akpm@osdl.org>
	<43219FDF0200007800024975@emea1-mh.id2.novell.com>
	<20050909112721.316f2dbb.akpm@osdl.org>
	<4325412D0200007800024DE1@emea1-mh.id2.novell.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" <JBeulich@novell.com> wrote:
>
> >>  I'd be curious to know how you, considering yourself in my
>  position,
>  >>  would have approached breaking up and submitting that size a
>  patch.
>  >
>  >a) Patches which affect the main kernel but which aren't really
>  >   debugger-related
> 
>  So it was right to start with those...
> 
>  >b) Patches which affect the main kernel and which are
>  debugger-related
>  >   (adding hooks, generalising interfaces, refactoring functions,
>  etc).
> 
>  ... and some of those. But you saying this was more or less the right
>  approach puts things in contradiction with the complaints from others
>  that consumers of some of the changes weren't immediately visible.
> 
>  >c) Finally, one monster patch to add the debugger functionality. 
>  Maybe
>  >   split into in vger-sized chunks.

There's confusion here between two separate concepts:

a) How patches should be presented (ie: the splitup)

b) When patches are to be merged into Linus's tree.

I have been discussing a) and you've been discussing b).

Regarding b): general cleanups/fixes/etc can of course go into Linus's tree
in the usual manner.

Preparatory patches for some large feature should be delivered as separate
patches so we can see what they're doing to the kernel but they won't
normally be merged until the same day as the large feature itself.
