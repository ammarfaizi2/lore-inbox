Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316605AbSFNE24>; Fri, 14 Jun 2002 00:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317431AbSFNE24>; Fri, 14 Jun 2002 00:28:56 -0400
Received: from host186-15.discord.birch.net ([65.16.186.15]:3050 "EHLO
	inspiron.random") by vger.kernel.org with ESMTP id <S316605AbSFNE2x>;
	Fri, 14 Jun 2002 00:28:53 -0400
Date: Thu, 13 Jun 2002 23:28:55 -0500
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
        Richard Brunner <richard.brunner@amd.com>, mark.langsdorf@amd.com
Subject: Re: New version of pageattr caching conflict fix for 2.4
Message-ID: <20020614042855.GA3679@inspiron.birch.net>
In-Reply-To: <20020613221533.A2544@wotan.suse.de> <20020613210339.B21542@redhat.com> <20020614032429.A19018@wotan.suse.de> <20020613213724.C21542@redhat.com> <20020614040025.GA2093@inspiron.birch.net> <20020614001726.D21542@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2002 at 12:17:26AM -0400, Benjamin LaHaise wrote:
> On Fri, Jun 14, 2002 at 06:00:25AM +0200, Andrea Arcangeli wrote:
> > just a fast comment on this bit: x86 specs state invlpg must flush
> > global entries from the tlb too, see also the kmap_prot as pratical
> > reference.
> 
> It's not the 4KB pages that I'm worried about so much as the 4MB pages.

I don't recall any spec mentioning that it doesn't work on large pages
so I thought it was safe to assume it had to work there too, I don't see
why it shouldn't, but it is certainly safe to go safe and double check.

IIRC the only bit to care about with the large pages is to flush with
the virtual address in the first half of the page to avoid falling into
an errata.

Andrea
