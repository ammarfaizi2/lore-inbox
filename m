Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132886AbRECQHn>; Thu, 3 May 2001 12:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132895AbRECQHd>; Thu, 3 May 2001 12:07:33 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:48392 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132886AbRECQHU>;
	Thu, 3 May 2001 12:07:20 -0400
Date: Thu, 3 May 2001 12:07:09 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, John Stoffel <stoffel@casc.com>,
        cate@dplanet.ch, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Requirement of make oldconfig [was: Re: [kbuild-devel] Re: CML2 1.3.1, aka ...]
Message-ID: <20010503120709.I31960@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	John Stoffel <stoffel@casc.com>, cate@dplanet.ch,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <alan@lxorguk.ukuu.org.uk> <200105031324.f43DOeaA030953@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105031324.f43DOeaA030953@pincoya.inf.utfsm.cl>; from vonbrand@inf.utfsm.cl on Thu, May 03, 2001 at 09:24:40AM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand <vonbrand@inf.utfsm.cl>:
>> No. Every new kernel changes the constraints so every new kernel you have
>> to reconfigure from scratch. That also makes it very hard to be sure you got
>> the results right.
> 
> Really? I've mostly seen symbols added, very rarely did I see constraints
> changed. But that might be just my narrow view on the matter...

It's mine as well.  And I have been paying careful attention to this issue.
 
> > oldconfig has a simple algorithm that works well for current cases
> > 
> > Start at the top of the symbols in file order. If a symbol is new ask the
> > user. If a symbol is now violating a constraint it gets set according to 
> > existing constraints if not it gets set to its old value.
> 
> I understand that to mean: "If it is new and (at least somewhat)
> unconstrained, ask the user.  If fully constrained, take that value
> unconditionally." This is a _very_ different case from a broken
> configuration as a starting point, in which constraints are violated with
> the values as set.

Exactly!  And in fact, my oldconfig already does what Alan prescribes.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

To make inexpensive guns impossible to get is to say that you're
putting a money test on getting a gun.  It's racism in its worst form.
        -- Roy Innis, president of the Congress of Racial Equality (CORE), 1988
