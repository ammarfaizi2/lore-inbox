Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310602AbSCPUkx>; Sat, 16 Mar 2002 15:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310613AbSCPUkq>; Sat, 16 Mar 2002 15:40:46 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24073 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S310625AbSCPUjr>; Sat, 16 Mar 2002 15:39:47 -0500
Date: Sat, 16 Mar 2002 12:38:01 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: <yodaiken@fsmlabs.com>, Andi Kleen <ak@suse.de>,
        Paul Mackerras <paulus@samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
In-Reply-To: <200203162036.g2GKaL513580@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.33.0203161236160.32013-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 16 Mar 2002, Richard Gooch wrote:
> 
> These are contiguous physical pages, or just logical (virtual) pages?

Contiguous virtual pages, but discontiguous physical pages.

The advantage being that you only need one set of virtual tags per "wide" 
entry, and you just fill the whole wide entry directly from the cacheline 
(ie the TLB entry is not really 32 bits any more, it's a full cacheline).

The _real_ advantage being that it should be totally invisible to 
software. I think Intel does something like this, but the point is, I 
don't even have to know, and it still works.

			Linus

