Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVBFRLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVBFRLh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 12:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVBFRKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 12:10:06 -0500
Received: from fw.osdl.org ([65.172.181.6]:32643 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261233AbVBFRI5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 12:08:57 -0500
Date: Sun, 6 Feb 2005 09:08:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, drepper@redhat.com
Subject: Re: [PROPOSAL/PATCH] Remove PT_GNU_STACK support before 2.6.11
In-Reply-To: <20050206142936.GC30476@wotan.suse.de>
Message-ID: <Pine.LNX.4.58.0502060907220.2165@ppc970.osdl.org>
References: <20050206120244.GA28061@elte.hu> <20050206124523.GA762@elte.hu>
 <20050206125002.GF30109@wotan.suse.de> <1107694800.22680.90.camel@laptopd505.fenrus.org>
 <20050206130152.GH30109@wotan.suse.de> <20050206130650.GA32015@infradead.org>
 <20050206131130.GJ30109@wotan.suse.de> <20050206133239.GA4483@elte.hu>
 <20050206134640.GB30476@wotan.suse.de> <20050206140802.GA6323@elte.hu>
 <20050206142936.GC30476@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Feb 2005, Andi Kleen wrote:
> 
> Force READ_IMPLIES_EXEC for all 32bit processes to fix
> the 32bit source compatibility.

Andi, stop this. We're _not_ going to say "32-bit executables don't need 
PROT_EXEC. The executables would need to be marked broken per-executable, 
not some kind of "we don't do this globally" setting.

		Linus
