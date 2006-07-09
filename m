Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161027AbWGIP2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbWGIP2E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 11:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161029AbWGIP2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 11:28:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2730 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161027AbWGIP2C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 11:28:02 -0400
Date: Sun, 9 Jul 2006 08:27:15 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Keith Owens <kaos@ocs.com.au>, Andi Kleen <ak@suse.de>,
       Jan Hubicka <jh@suse.cz>, "David S. Miller" <davem@davemloft.net>,
       Richard Henderson <rth@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile' 
In-Reply-To: <Pine.LNX.4.64.0607091618220.17704@scrub.home>
Message-ID: <Pine.LNX.4.64.0607090825380.5623@g5.osdl.org>
References: <31410.1152414469@ocs3.ocs.com.au> <Pine.LNX.4.64.0607082041400.5623@g5.osdl.org>
 <Pine.LNX.4.64.0607091618220.17704@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 9 Jul 2006, Roman Zippel wrote:
> 
> On Sat, 8 Jul 2006, Linus Torvalds wrote:
> > 
> > but we've been using that "+m" format for a long time already (and I 
> > _think_ we did so at the suggestion of gcc people), and it would be much 
> > better if the gcc documentation was just fixed here.
> 
> IIRC early 4.0 had problems with "+m" and did what the documentation says, 
> but that got quickly fixed.
> Here is the old thread http://marc.theaimsgroup.com/?t=108384517900001&r=1&w=2

Thanks. That one implies that we had some strange warnings (but it 
apparently still worked) with 3.4, and it's since gotten fixed. Goodie. 

I'll leave the "+m" alone then, both the old and the new ones.

		Linus
