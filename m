Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265624AbTHLKAt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 06:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270203AbTHLKAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 06:00:49 -0400
Received: from almesberger.net ([63.105.73.239]:15109 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S265624AbTHLKAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 06:00:37 -0400
Date: Tue, 12 Aug 2003 07:00:07 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Larry McVoy <lm@bitmover.com>, davej@redhat.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, dri-devel@lists.sourceforge.net
Subject: Re: [PATCH] CodingStyle fixes for drm_agpsupport
Message-ID: <20030812070007.A8269@almesberger.net>
References: <E19mF4Y-0005Eg-00@tetrachloride> <20030811164012.GB858@work.bitmover.com> <3F37CB44.5000307@pobox.com> <20030811170425.GA4418@work.bitmover.com> <3F37CF4E.3010605@pobox.com> <20030811172333.GA4879@work.bitmover.com> <3F37D80D.5000703@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F37D80D.5000703@pobox.com>; from jgarzik@pobox.com on Mon, Aug 11, 2003 at 01:53:17PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Also, having two styles 
> of 'if' formatting in your example just screams "inconsistent" to me :)

Naw, it's only one style:

<stmt> ::= if (<expression>) <stmt>
<stmt> ::= { <newline> <stmts> } <newline>
<stmt> ::= <expression> ; <newline>
etc.

Perfectly consistent. ("Always end a statement with a newline.")

> Ug.  The first and last 'if' need spreading out away from the big fat 
> block,

Why waste a perfectly good punch card on that second line ? :-)

My own formatting rules for "if" go about like this:

 1) if "if" and the statement fit on a single line, put them accordingly
    ("vertical space is precious")

 2) if the line needs to wrap (I wrap at the 79th column), always put
    the statement on a separate line, fully indented ("wrap at the
    highest hierarchical level")

 3) likewise for "else" and statement. Here, 2) doesn't apply for kernel
    code, which uses a full tab for indentation - in my user-space code,
    I use only four spaces, so sometimes, I get
    else
        stuff_that_just_happens_to_be_too_long_by_one_silly_little_character();

 4) if the statement is a block, and there is an "else" branch with a
    single statement, invert the condition ("don't hide the fine print")

Since I'm the only sentient being in the universe, and all the rest
of you are just figments of my imagination, it's fairly obvious that
my style is The Right Style :-)

> and the "return (whatever)" fools your eyes into thinking they 
> are function calls at a 10-nanosecond glance. 

Yeah, I hate that too.

Larry:
> > I also make people do
> > 
> > 	if ((a <= B) || (c >= d)) {

Argl. That's one place where the precedence works beautifully.
Extra parentheses in trivial cases always make me suspect that
the author was actually trying to do something else.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
