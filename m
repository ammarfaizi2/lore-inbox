Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292238AbSBOWdo>; Fri, 15 Feb 2002 17:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292235AbSBOWcN>; Fri, 15 Feb 2002 17:32:13 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:8979
	"EHLO golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S292226AbSBOWb2>; Fri, 15 Feb 2002 17:31:28 -0500
Date: Fri, 15 Feb 2002 17:04:59 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Dave Jones <davej@suse.de>, Larry McVoy <lm@work.bitmover.com>,
        Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020215170459.A15406@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Dave Jones <davej@suse.de>, Larry McVoy <lm@work.bitmover.com>,
	Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020215135557.B10961@thyrsus.com> <200202151929.g1FJTaU03362@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215141433.B11369@thyrsus.com> <20020215195818.A3534@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215145421.A12540@thyrsus.com> <20020215124255.F28735@work.bitmover.com> <20020215153953.D12540@thyrsus.com> <20020215221532.K27880@suse.de> <20020215155817.A14083@thyrsus.com> <20020215224916.L27880@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020215224916.L27880@suse.de>; from davej@suse.de on Fri, Feb 15, 2002 at 10:49:16PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@suse.de>:
>  As you obviously completely ignored my previous point, I'll reiterate it.
> 
>  1. You run Linus' split-into-config.in script on a 2.4 tree.
>  2. You add whatever Config.ins have been updated to the 2.4 config.ins
>  3. You regenerate with the find example I showed in the other mail.
> 
>  There. 2.4 Configure.help up to date with latest symbols, but
>  containing none of the 2.5 ones.

And you've completely ignored the real problem...which is when I get
a text change for one tree, *how do I automatically propagate it to
the other*?  How do I *tell* that it ought to be propagated?  

It's not sufficient to develop a one-shot conversion procedure.  What
I came up with had to allow me to continue generating correct help 
files for all trees under the assumption that text changes for 2.4
could come in against the 2.5 copy of the help entry, or vice-versa --
bearing in mind that some symbols have divergent text and that's correct.

Solutions that involve me doing an arbitrary and increasing amount of
hand-hacking on every release are right out.

If you think this problem through, I'm sure you'll come up with a
design very similar to what I actually built.  Which, by Linus's
choice, got irrecoverably nuked.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
