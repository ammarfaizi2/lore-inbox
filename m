Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261723AbSLMJNa>; Fri, 13 Dec 2002 04:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbSLMJNa>; Fri, 13 Dec 2002 04:13:30 -0500
Received: from elin.scali.no ([62.70.89.10]:57608 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id <S261723AbSLMJN2>;
	Fri, 13 Dec 2002 04:13:28 -0500
Subject: Re: Intel P6 vs P7 system call performance
From: Terje Eggestad <terje.eggestad@scali.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Mark Mielke <mark@mark.mielke.cc>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>
In-Reply-To: <20021212205655.GA1658@werewolf.able.es>
References: <1039610907.25187.190.camel@pc-16.office.scali.no>
	 <3DF78911.5090107@zytor.com>
	 <1039686176.25186.195.camel@pc-16.office.scali.no>
	 <20021212203646.GA14228@mark.mielke.cc>
	 <20021212205655.GA1658@werewolf.able.es>
Content-Type: text/plain
Organization: Scali AS
Message-Id: <1039771270.29298.41.camel@pc-16.office.scali.no>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 13 Dec 2002 10:21:11 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On tor, 2002-12-12 at 21:56, J.A. Magallon wrote:
> On 2002.12.12 Mark Mielke wrote:
> >On Thu, Dec 12, 2002 at 10:42:56AM +0100, Terje Eggestad wrote:
> >> On ons, 2002-12-11 at 19:50, H. Peter Anvin wrote:
> >> > Terje Eggestad wrote:
> >> > > PS:  rdtsc on P4 is also painfully slow!!!
> >> > Now that's just braindead...
> >> It takes about 11 cycles on athlon, 34 on PII, and a whooping 84 on P4.
> >> For a simple op like that, even 11 is a lot... Really makes you wonder.
> >
> >Some of this discussion is a little bit unfair. My understanding of what
> >Intel has done with the P4, is create an architecture that allows for
> >higher clock rates. Sure the P4 might take 84, vs PII 34, but how many
> >PII 2.4 Ghz machines have you ever seen on the market?
> >
> >Certainly, some of their decisions seem to be a little odd on the surface.
> >
> >That doesn't mean the situation is black and white.
> >
> 
> No. The situation is just black. Each day Intel processors are a bigger
> pile of crap and less intelligent, but MHz compensate for the average
> office user. Think of what could a P4 do if the same effort put on
> Hz was put on getting cheap a cache of 4Mb or 8Mb like MIPSes have. Or
> closer, 1Mb like G4s.
> If syscalls take 300% time but processor is also 300% faster 'nobody
> notices'.
  
Well, it does make sense if Intel optimized away rdtsc for more commonly
used things, but even that don't seem to be the case. I'm measuring the
overhead of doing a syscall on Linux (int 80) to be ~280 cycles on PIII,
and Athlon, while it's 1600 cycles on P4.

TJ


 
-- 
_________________________________________________________________________

Terje Eggestad                  mailto:terje.eggestad@scali.no
Scali Scalable Linux Systems    http://www.scali.com

Olaf Helsets Vei 6              tel:    +47 22 62 89 61 (OFFICE)
P.O.Box 150, Oppsal                     +47 975 31 574  (MOBILE)
N-0619 Oslo                     fax:    +47 22 62 89 51
NORWAY            
_________________________________________________________________________

