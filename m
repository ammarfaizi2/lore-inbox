Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317880AbSFNEA0>; Fri, 14 Jun 2002 00:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317882AbSFNEAZ>; Fri, 14 Jun 2002 00:00:25 -0400
Received: from host186-15.discord.birch.net ([65.16.186.15]:62180 "EHLO
	inspiron.random") by vger.kernel.org with ESMTP id <S317880AbSFNEAZ>;
	Fri, 14 Jun 2002 00:00:25 -0400
Date: Fri, 14 Jun 2002 06:00:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
        Richard Brunner <richard.brunner@amd.com>, mark.langsdorf@amd.com
Subject: Re: New version of pageattr caching conflict fix for 2.4
Message-ID: <20020614040025.GA2093@inspiron.birch.net>
In-Reply-To: <20020613221533.A2544@wotan.suse.de> <20020613210339.B21542@redhat.com> <20020614032429.A19018@wotan.suse.de> <20020613213724.C21542@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2002 at 09:37:24PM -0400, Benjamin LaHaise wrote:
> On Fri, Jun 14, 2002 at 03:24:29AM +0200, Andi Kleen wrote:
> > > This version is missing a few of the fixes included in my version: 
> > > it doesn't properly flush global tlb entries, or update the page 
> > 
> > Sure it does. INVLPG (__flush_tlb_one) flushes global entries.
> 
> It failed to do so in my testing.  The only safe way of flushing 

just a fast comment on this bit: x86 specs state invlpg must flush
global entries from the tlb too, see also the kmap_prot as pratical
reference.

Andrea
