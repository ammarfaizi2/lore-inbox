Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280648AbRKGDYh>; Tue, 6 Nov 2001 22:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280751AbRKGDY1>; Tue, 6 Nov 2001 22:24:27 -0500
Received: from alcove.wittsend.com ([130.205.0.10]:64132 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S280648AbRKGDYT>; Tue, 6 Nov 2001 22:24:19 -0500
Date: Tue, 6 Nov 2001 22:24:07 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Anuradha Ratnaweera <anuradha@gnu.org>
Cc: Robert Love <rml@tech9.net>, torvalds@transmeta.com,
        Mike Fedyk <mfedyk@matchmail.com>, Terminator <jimmy@mtc.dhs.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Are -final releases realy FINAL? (Was Re: kernel 2.4.14 compiling fail for loop device)
Message-ID: <20011106222407.A6360@alcove.wittsend.com>
Mail-Followup-To: Anuradha Ratnaweera <anuradha@gnu.org>,
	Robert Love <rml@tech9.net>, torvalds@transmeta.com,
	Mike Fedyk <mfedyk@matchmail.com>, Terminator <jimmy@mtc.dhs.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0111051936090.18663-100000@www.mtc.dhs.org> <20011105194316.B665@mikef-linux.matchmail.com> <1005019360.897.2.camel@phantasy> <20011107091314.A11202@bee.lk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011107091314.A11202@bee.lk>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 09:13:14AM +0600, Anuradha Ratnaweera wrote:
> On Mon, Nov 05, 2001 at 11:02:36PM -0500, Robert Love wrote:
> >
> > On Mon, 2001-11-05 at 22:43, Mike Fedyk wrote:
> > >
> > > Did anyone have this problem with pre8???

	No, there was a different problem that required hand patching.

> > Nope, it was added post-pre8 to final.  The deactivate_page function was
> > removed completely.
> 
> Look, Linus.  Things should _not_ happen this way.

> Why do we add non-trivial changes when going from last -preX of a test kernel
> series to -final?

> Please make the last stable -preX the -final _without_ any changes.  This is
> the third time this caused problem in recent times (2.4.11-dontuse, parport
> compile problems and now loop.o), and why don't we learn from previous
> mistakes?

> Isn't it stupid that some tarballs in the /pub/linux/kernel/v2.4/ do not even
> compile, while those in /pub/linux/kernel/testing/ does?

	linux-2.4.14-pre8 did not compile either if rd.o or loop.o
were compiled as modules, but the names were changed to protect the
guilty (different symbol name, one that wasn't exported).

	Maybe there should have been another -pre.  But the only reason
I was staying on top of the -pre kernels was because I had several major
changes in there, this time around.

> Regards,

> Anuradha

> -- 

> Debian GNU/Linux (kernel 2.4.14-pre7)

	-pre7 actually did compile.  -pre8 did not (not without adding
a line to ksyms.c).

> I cannot conceive that anybody will require multiplications at the rate
> of 40,000 or even 4,000 per hour ...
> 		-- F. H. Wales (1936)

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  /\/\|=mhw=|\/\/       |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!
