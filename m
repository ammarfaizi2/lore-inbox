Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbTEBFBB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 01:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTEBFBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 01:01:01 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25868 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261783AbTEBFBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 01:01:00 -0400
Date: Thu, 1 May 2003 22:14:25 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "David S. Miller" <davem@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Faster generic_fls
In-Reply-To: <1051790452.8772.18.camel@rth.ninka.net>
Message-ID: <Pine.LNX.4.44.0305012212190.5230-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 1 May 2003, David S. Miller wrote:
> 
> This actually is false.  GCC does not know what resources the
> instruction uses, therefore it cannot perform accurate instruction
> scheduling.

Yeah, and sadly the fact that gcc-3.2.x does better instruction scheduling 
has shown itself to not actually _matter_ that much. I'm quite impressed 
by the new scheduler, but gcc-2.x seems to still generate faster code on 
too many examples.

CPU's are getting smarter, not dumber. And that implies, for example, that 
instruction scheduling matters less and less. What matters on the P4, for 
example, seems to be the _choice_ of instructions, not the scheduling of 
them.

			Linus

