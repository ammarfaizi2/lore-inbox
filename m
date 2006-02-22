Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751288AbWBVOFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbWBVOFj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 09:05:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbWBVOFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 09:05:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:16288 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751288AbWBVOFh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 09:05:37 -0500
X-Authenticated: #428038
Date: Wed, 22 Feb 2006 15:05:28 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] portable Makefiles (was: CD writing in future Linux (stirring up a hornets' nest))
Message-ID: <20060222140528.GB13283@merlin.emma.line.org>
Reply-To: Matthias Andree <matthias.andree@gmx.de>
Mail-Followup-To: Matthias Andree <matthias.andree@gmx.de>
References: <43EB7BBA.nailIFG412CGY@burner> <200602171502.20268.dhazelton@enter.net> <43F9D771.nail4AL36GWSG@burner> <200602201302.05347.dhazelton@enter.net> <43FAE10F.nailD121QL6LN@burner> <20060221101644.GA19643@merlin.emma.line.org> <43FAF2FA.nailD12BW90DH@burner> <20060221114625.GA29439@merlin.emma.line.org> <43FC68C1.nailEC711MJAV@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FC68C1.nailEC711MJAV@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-02-22:

> > - run Solaris' /usr/{ccs,xpg4}/bin/make
> >   to find out if your Makefile is portable
> 
> Solaris make does not write useful error messages in case of non-portable 
> makefiles.

Sun Microsystems do not advertise their make tool as Makefile
portability validator.  Note the difference: each tool is held to its
own standards.

> > - run BSD's portable make (that's a proper name)
> >   to find out if your Makefile is portable
> 
> BSD make may be portable (although I am sure that smake comppiles/runs
> on much more platforms) but it is not POSIX compliant.

Please look up the term "proper name" before continuing. BSD make does
not mention "POSIX" a single time in its documentation.

> After we fixed the bug with pattern macro expansions in FreeBSDs make,
> it turned out that cc -o some/dir/to/file.o file.c is handled completely
> different from UNIX make programs. This makes it impossible to use FreeBSD
> make for e.g. the Schily makefilesystem.

If BSD make is not UNIX make, then what is?

That FreeBSD's /usr/bin/make doesn't like your Makefiles doesn't matter,
GNU and Schily make are available in the ports collection, either is fine.

> > - testing real-world make programs with Makefiles will find out much
> >   more reliably if non-portable constructs are used.
> 
> ??? smake _is_ a real world make program and if you rate POSIX compliance
> and portability, it will outstrip all other known make programs.

You still haven't got my point. Last attempt to explain:

smake isn't sufficient to judge if a "Makefile" is portable to all
widespread make programs, particularly does it not warn about non-POSIX
syntax that SUN make or BSD make reject, as shown in my previous message.

> > This is pretty strong evidence that smake is insufficient as
> > Makefile portability validator, which substantiates my recommendation to
> > test real-world make(1) programs rather than smake to find out the
> > portability characteristics.
> 
> The other make programs I know are worse then smake and they are usually not
> portable themself. Note that I don't like to use the technology from the 1970s
> as GNU "automake" does.

Your dislike for GNU make is widely documented, yet only based on
cosmetic bugs. Try if the "remake" guys fix the concerns you have had
about GNU make. remake is a GNU make spinoff with usability
improvements, getting rid of meaningless "Makefile:5: foo.d: No such
file or directory" should be well within reach. Dig through your
sent-mail folder for the explanation you sent me a year or two ago.
See <http://bashdb.sourceforge.net/remake/>

I'm redirecting answers off-list.
This isn't linux-kernel stuff any more.

BTW, your Message-ID is nonconformant (it doesn't use a qualified domain
name, "burner" isn't appropriate), please fix your mailer.

-- 
Matthias Andree
