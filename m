Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271501AbRH3VdH>; Thu, 30 Aug 2001 17:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271364AbRH3Vc5>; Thu, 30 Aug 2001 17:32:57 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:10506 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S271671AbRH3Vcr>;
	Thu, 30 Aug 2001 17:32:47 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200108302132.f7ULWt221345@oboe.it.uc3m.es>
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <10868.999206096@redhat.com> from "David Woodhouse" at "Aug 30,
 2001 10:14:56 pm"
To: "David Woodhouse" <dwmw2@infradead.org>
Date: Thu, 30 Aug 2001 23:32:55 +0200 (MET DST)
CC: ptb@it.uc3m.es, "Herbert Rosmanith" <herp@wildsau.idv-edu.uni-linz.ac.at>,
        linux-kernel@vger.kernel.org, dhowells@cambridge.redhat.com
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David Woodhouse wrote:"
> 
> ptb@it.uc3m.es said:
> >  And I was hoping that somebody could produce some gcc magic
> > replacement for BUG() that means "don't compile me". Perhaps a bit of
> > illegal assembler code with a line reference in? Surely gcc must have
> > something like __builtin_wont_compile()? It just needs to be a leaf of
> > the RTL that evokes a compile error.
> 
> It's done. I believe it was called __builtin_ct_assertion(). I don't think 
> it got merged (yet?).

Now I think of it, I suppose

    unsafe_min_or_max_at_line_##__LINE__()

will definitely evoke a meaningful link error.

I still suspect that illegal assembler will do the job, since it must
be treated after gcc has produced assembler itself and line references
must still be present then for the assembler to be able to give meaningful
error messages (;), but assembler is not something I write, so someone
else needs to say.

Peter
