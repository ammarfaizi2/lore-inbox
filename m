Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283073AbRLDMB7>; Tue, 4 Dec 2001 07:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283059AbRLDMBu>; Tue, 4 Dec 2001 07:01:50 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:34994
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S283064AbRLDMBh>; Tue, 4 Dec 2001 07:01:37 -0500
Date: Tue, 4 Dec 2001 06:52:12 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Keith Owens <kaos@ocs.com.au>, kbuild-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204065212.A10990@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Keith Owens <kaos@ocs.com.au>, kbuild-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <20011202201946.A7662@thyrsus.com> <1861.1007341572@kao2.melbourne.sgi.com> <20011202201946.A7662@thyrsus.com> <10297.1007463859@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <10297.1007463859@redhat.com>; from dwmw2@infradead.org on Tue, Dec 04, 2001 at 11:04:19AM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org>:
> 
> esr@thyrsus.com said:
> >  The schedule I heard from Linus at the kernel summit was that both
> > changes  were to go in between 2.5.1 and 2.5.2.   I would prefer
> > sooner than later  because I'm *really* *tired* of maintaining a
> > parallel rulebase.
> 
> Is it not possible to write an automatic conversion tool that reads the 
> existing CML1 files and outputs CML2 rules with identical behaviour?

No, it's not.  

Nobody wishes more than me that this had been possible, as the
parallel CML2 rulebase has been an energy sink you wouldn't believe --
it has eaten more of my time than any other single project I've been
involved with in the last two years.

Unfortunately, the syntax of CML1 is rebarbative, and its imperative 
semantics cannot be mechanically translated to CML2's declarative 
semantics by any means I'm aware of.

> After all, the only way for the merge of CML2 to be acceptable is to merge
> the tools _first_, without changing the resulting behaviour of the config
> rules, and then to make behavioural changes in later versions.

That's a different issue.  The CML2 rulebase does produce behavior 
substantially like that of the CML1 rulebase in most respects.  There
are divergences due to the single-apex tree, but nothing that has caused
any of the beta testers a problem.  I sweated blood to make it so.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Are we to understand," asked the judge, "that you hold your own interests
above the interests of the public?"

"I hold that such a question can never arise except in a society of cannibals."
	-- Ayn Rand
