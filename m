Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315419AbSFNE2H>; Fri, 14 Jun 2002 00:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316605AbSFNE2H>; Fri, 14 Jun 2002 00:28:07 -0400
Received: from ns.suse.de ([213.95.15.193]:15119 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315419AbSFNE2G>;
	Fri, 14 Jun 2002 00:28:06 -0400
Date: Fri, 14 Jun 2002 06:27:54 +0200
From: Andi Kleen <ak@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org,
        Richard Brunner <richard.brunner@amd.com>, mark.langsdorf@amd.com
Subject: Re: New version of pageattr caching conflict fix for 2.4
Message-ID: <20020614062754.A11232@wotan.suse.de>
In-Reply-To: <20020613221533.A2544@wotan.suse.de> <20020613210339.B21542@redhat.com> <20020614032429.A19018@wotan.suse.de> <20020613213724.C21542@redhat.com> <20020614040025.GA2093@inspiron.birch.net> <20020614001726.D21542@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2002 at 12:17:26AM -0400, Benjamin LaHaise wrote:
> On Fri, Jun 14, 2002 at 06:00:25AM +0200, Andrea Arcangeli wrote:
> > just a fast comment on this bit: x86 specs state invlpg must flush
> > global entries from the tlb too, see also the kmap_prot as pratical
> > reference.
> 
> It's not the 4KB pages that I'm worried about so much as the 4MB pages.

Both AMD x86-64 and Intel IA32 documentation states that INVLPG flushes global
TLBs. The first version of change_page_attr did in fact use __flush_tlb_all,
but I changed it after checking the docs.

-Andi
