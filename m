Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266930AbTAJTej>; Fri, 10 Jan 2003 14:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267029AbTAJTej>; Fri, 10 Jan 2003 14:34:39 -0500
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:40967 "HELO
	ritz.dnsalias.org") by vger.kernel.org with SMTP id <S266930AbTAJTeh>;
	Fri, 10 Jan 2003 14:34:37 -0500
Subject: Re: [PATCH 2.5] speedup kallsyms_lookup
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Robert Love <rml@tech9.net>
Cc: Hugh Dickins <hugh@veritas.com>,
       William Lee Irwin III <wli@holomorphy.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1042218917.722.15.camel@phantasy>
References: <Pine.LNX.4.44.0301101628460.1434-100000@localhost.localdomain>
	 <1042218917.722.15.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 10 Jan 2003 20:44:00 +0100
Message-Id: <1042227852.1404.2.camel@cast2.alcatel.ch>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hmm...i don't see why i want wchan. tell me.
but you're right, for some reason linus merged it. so i think (if it's
kept) we should restrict it a bit and make the kallsyms_lookup a bit
faster. not a super fast complex algorithm, but at least not that
braindead as it currently is...

btw. does my ugly early-in-the-moring-hack work right?

On Fri, 2003-01-10 at 18:15, Robert Love wrote:
> On Fri, 2003-01-10 at 11:34, Hugh Dickins wrote:
> 
> > Indeed!  I think that was Andi volunteering :-}
> > But we should let rml defend his wchan.
> 
> Well, of course I want to keep it - but I am biased :)
> 
> I think its a simple export that gives us a neat feature.  Additionally,
> from the procps perspective, it saves us from having to parse System.map
> for each process.  In fact, it means we do not need a System.map at all
> for any procps functionality.
> 
> I guess Linus at least mildly liked it too, since he merged it.
> 
> But if its such a performance crippling item perhaps it does need to be
> removed (or somehow restricted).
> 
> I do agree that, if possible, wchan should be kept simple... so, is
> everyone else for the removal of /proc/pid/wchan ? :-(
> 
> 	Robert Love
> 


