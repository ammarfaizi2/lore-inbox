Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292407AbSBPQWG>; Sat, 16 Feb 2002 11:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292405AbSBPQVr>; Sat, 16 Feb 2002 11:21:47 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:34312
	"EHLO golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S292404AbSBPQVp>; Sat, 16 Feb 2002 11:21:45 -0500
Date: Sat, 16 Feb 2002 10:54:25 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave Jones <davej@suse.de>, Robert Love <rml@tech9.net>,
        Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020216105425.A31986@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Jones <davej@suse.de>,
	Robert Love <rml@tech9.net>,
	Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020215171130.C15406@thyrsus.com> <E16brRz-0004Zj-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16brRz-0004Zj-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Feb 15, 2002 at 11:07:31PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > The kernel rulebase cannot.  The real issue here is whether the CML1 
> > language carries sufficient information to support things like 
> > side-effect deduction.  And the answer is "no".
> 
> Thats an opinion not an answer. What doesn't it contain ?

New FAQ entry:

* Inventing CML2 was unnecessary, since CML1 carries enough information to
  do consistency checking and side-effect forcing.

Jeff Garzik observed:
>I was tempted to introduce a "requires" token to express dependencies
>between subsystems, because I feel they are different from the other
>dependencies present,

Alan followed up with:
>The only interesting case I could find is the negation one - some
>rules are A conflicts with B which makes the UI side much more fun

Jeff and Alan have put their finger neatly on one of the key bits CML2
can do that CML1 cannot -- express cross-directory dependencies in
such a way that the configurator can force side effects in both
directions.  This is, in fact, the very rock on which my original
attempt to save CML1 foundered after six weeks of effort.

-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
