Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135910AbRDTNTc>; Fri, 20 Apr 2001 09:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135911AbRDTNTX>; Fri, 20 Apr 2001 09:19:23 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:6928 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135910AbRDTNTG>;
	Fri, 20 Apr 2001 09:19:06 -0400
Date: Fri, 20 Apr 2001 09:18:34 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Wilcox <willy@ldl.fc.hp.com>, linux-kernel@vger.kernel.org,
        parisc-linux@parisc-linux.org
Subject: Re: [parisc-linux] Re: OK, let's try cleaning up another nit. Is anyone paying attention?
Message-ID: <20010420091834.A5102@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Matthew Wilcox <willy@ldl.fc.hp.com>, linux-kernel@vger.kernel.org,
	parisc-linux@parisc-linux.org
In-Reply-To: <20010419230009.A32500@thyrsus.com> <E14qaeC-0001DZ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14qaeC-0001DZ-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Apr 20, 2001 at 02:08:25PM +0100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > What is the right procedure for doing changes like this?  Is "don't
> > touch that tree" a permanent condition, or am I going to get a chance
> > to clean up the global CONFIG_ namespace after your next merge-down?
> 
> Feeding arch related stuff to the architecture maintainers.

I shall attempt it.

> > That's the main thing I'm after right now -- I want to cut down on
> > the false positives in my orphaned-symbol reports so that the actual
> > bugs will stand out.
> 
> Teach it to read a 'symbolstoignore' file.

Someone else has already pointed out that this is not a solution that will
scale well.  It would substitute a continuing management headache for the
cleanup that's really needed.  In fact I'm reluctant to do this even for 
cases where it's clearly legitimate (CONFIG_BOOM, CONFIG_BOGUS :-)) partly
because later on it might provide an excuse for people not to do the cleanup.

> Part of the problem you are hitting right now is that most
> architectures are not yet fully in sync with 2.4 nor likely to all
> be for another few iterations.

Understood.  I'll do what I can in the architecture-independent code, then.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Boys who own legal firearms have much lower rates of delinquency and
drug use and are even slightly less delinquent than nonowners of guns."
	-- U.S. Department of Justice, National Institute of
	   Justice, Office of Juvenile Justice and Delinquency Prevention,
	   NCJ-143454, "Urban Delinquency and Substance Abuse," August 1995.
