Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281170AbRLDRMq>; Tue, 4 Dec 2001 12:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281075AbRLDRLa>; Tue, 4 Dec 2001 12:11:30 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:22708
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S281165AbRLDRK4>; Tue, 4 Dec 2001 12:10:56 -0500
Date: Tue, 4 Dec 2001 12:03:05 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@caldera.de>,
        Keith Owens <kaos@ocs.com.au>, kbuild-devel@lists.sourceforge.net,
        torvalds@transmeta.com
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
Message-ID: <20011204120305.A16578@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@caldera.de>,
	Keith Owens <kaos@ocs.com.au>, kbuild-devel@lists.sourceforge.net,
	torvalds@transmeta.com
In-Reply-To: <1861.1007341572@kao2.melbourne.sgi.com> <20011204131136.B6051@caldera.de> <20011204072808.A11867@thyrsus.com> <20011204133932.A8805@caldera.de> <20011204074815.A12231@thyrsus.com> <20011204140050.A10691@caldera.de> <20011204081640.A12658@thyrsus.com> <20011204142958.A14069@caldera.de> <20011204173309.A10746@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011204173309.A10746@emma1.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Tue, Dec 04, 2001 at 05:33:09PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@stud.uni-dortmund.de>:
> Seriously: what do you fear? Losing the efforts you put into mconfig?
> Linux 2.2 and 2.4 will be around for quite some time (not sure about
> mconfig on 2.0, I don't use 2.0.x ATM).

Oops.  I wasn't going to tell anyone this yet, but since you've made
this argument I feel I must be up front here....

After CML2 has proven itself in 2.5, I do plan to go back to Marcelo
and lobby for him accepting it into 2.4, on the grounds that doing so
will simplify his maintainance task no end.  That's why I'm tracking
both sides of the fork in the rulebase, so it will be an easy drop-in
replacement for Marcelo as well as Linus.

> What are the precise issues with Python? Just claiming it is an issue is
> not useful for discussing this. Archive pointers are welcome.

The issues can be divided into two groups: silly and serious.  The 
representative silly objection was "Python is evil because significant
whitespace sucks!".  Cristoph's objection to the use of a binary pickle 
as an intermediate format is in this category also.

I heard two serious objections: 

(1) The overhead of learning a new config language is too high.

(2) Requiring Python introduces another tool into the requisites list for
kernel building.  

As to (1), the very people who maintained the in-kernel CML1 tools
judged that the overhead of sticking with what they wrote was
forseeably going to be higher than that of putting a new language in
place.  Otherwise they would not have encouraged me to replace it when
I offered.

As to (2), I could make all kinds of elaborate defensive technical 
arguments, or I could point at Greg Bank's CML2-in-C project, but 
screw that.  I'm just going to say "Today's problems, today's tools."
Progress happens. If you don't like it, feel free to go back to 
writing Autocoder on your 1401.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"The state calls its own violence `law', but that of the individual `crime'"
	-- Max Stirner
