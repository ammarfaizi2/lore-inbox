Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130227AbRCCCFW>; Fri, 2 Mar 2001 21:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130228AbRCCCFM>; Fri, 2 Mar 2001 21:05:12 -0500
Received: from adsl-63-200-86-10.dsl.scrm01.pacbell.net ([63.200.86.10]:51842
	"EHLO frx774.dhs.org") by vger.kernel.org with ESMTP
	id <S130227AbRCCCFG>; Fri, 2 Mar 2001 21:05:06 -0500
From: Jesse Wyant <jrwyant@frx774.dhs.org>
Message-Id: <200103030205.f23253x14898@frx774.dhs.org>
Subject: Re: 2.4.2 TCP window shrinking
To: linux-kernel@vger.kernel.org
Date: Fri, 2 Mar 2001 18:05:03 -0800 (PST)
In-Reply-To: <Pine.LNX.4.32.0103021908230.25035-100000@tux.creighton.edu> from "Phil Brutsche" at Mar 02, 2001 07:27:55 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Similar situation here: vanilla 2.4.2, with web serving/ftp/hotline/napster/etc.,
and I get this:

TCP: peer 148.75.118.138:1360/6699 shrinks window 3200785160:0:3200795086. Bad, what else can I say?
TCP: peer 148.75.118.138:1359/6699 shrinks window 3054879436:0:3054885108. Bad, what else can I say?
TCP: peer 148.75.118.138:1360/6699 shrinks window 3201450202:0:3201458710. Bad, what else can I say?
TCP: peer 148.75.118.138:1361/6699 shrinks window 3317649733:0:3317653987. Bad, what else can I say?
TCP: peer 148.75.118.138:1359/6699 shrinks window 3054934738:0:3054940410. Bad, what else can I say?
TCP: peer 148.75.118.138:1357/6699 shrinks window 2520518983:0:2520527491. Bad, what else can I say?
TCP: peer 148.75.118.138:1359/6699 shrinks window 3054990040:0:3054995712. Bad, what else can I say?
TCP: peer 148.75.118.138:1359/6699 shrinks window 3055011310:0:3055014146. Bad, what else can I say?
TCP: peer 148.75.118.138:1360/6699 shrinks window 3201522520:0:3201528192. Bad, what else can I say?
TCP: peer 148.75.118.138:1357/6699 shrinks window 2520598391:0:2520599809. Bad, what else can I say?
TCP: peer 148.75.118.138:1359/6699 shrinks window 3055146020:0:3055148856. Bad, what else can I say?
TCP: peer 148.75.118.138:1361/6699 shrinks window 3317713543:0:3317723469. Bad, what else can I say?
TCP: peer 148.75.118.138:1360/6699 shrinks window 3201592002:0:3201599092. Bad, what else can I say?
TCP: peer 148.75.118.138:1360/6699 shrinks window 3201593420:0:3201599092. Bad, what else can I say?
TCP: peer 148.75.118.138:1357/6699 shrinks window 2520676381:0:2520680635. Bad, what else can I say?
TCP: peer 148.75.118.138:1360/6699 shrinks window 3201607600:0:3201614690. Bad, what else can I say?

Running nmap (v2.53) on that IP doesn't resolve to a known OS, so that doesn't help.  Version 2.54BETA7
gives this output:

  Starting nmap V. 2.54BETA7 ( www.insecure.org/nmap/ )
  Warning:  OS detection will be MUCH less reliable because we did not find at least 1 open and 1 closed TCP port
  All 1534 scanned ports on vsat-148-75-118-138.ssa7.mcl.starband.net (148.75.118.138) are: filtered
  Remote OS guesses: Apple LaserWriter 16/600 PS, HP 6P, or HP 5 Printer, Apple LaserWriter 8500 (PostScript version 3010.103), MultiTech MultiVOIP Version 2.01A Firmware, Mulit-Tech standalone firewall box, version 3, MultiTech CommPlete (modem server) RAScard, Xerox 8830 Plotter, Xerox DocuPrint C55, Xerox DocuPrint N40

  Nmap run completed -- 1 IP address (1 host up) scanned in 163 seconds

So that doesn't appear to help too much either.

> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> A long time ago, in a galaxy far, far way, someone said...
> 
> >
> > Jim Woodward writes:
> >  > This has probably been covered but I saw this message in my logs and
> >  > wondered what it meant?
> >  >
> >  > TCP: peer xxx.xxx.1.11:41154/80 shrinks window 2442047470:1072:2442050944.
> >  > Bad, what else can I say?
> >  >
> >  > Is it potentially bad? - Ive only ever seen it twice with 2.4.x
> >
> > We need desperately to know exactly what OS the xxx.xxx.1.14 machine
> > is running.  Because you've commented out the first two octets, I
> > cannot check this myself using nmap.
> 
> I'm seeing similar messages on a web server running 2.4.2.
> 
> Some of hosts I've seen it with are:
> 
> 205.188.208.172
> 209.240.220.172
> 209.240.220.173
> 209.240.220.174
> 209.240.220.176
> 209.240.220.177
> 216.239.46.17
> 216.239.46.27
> 216.239.46.34
> 216.239.46.168
> 130.239.126.113
> 206.190.23.112
> 193.130.225.253
> 
> - -- 
> - ----------------------------------------------------------------------
> Phil Brutsche				    pbrutsch@tux.creighton.edu
> 
> GPG fingerprint: 9BF9 D84C 37D0 4FA7 1F2D  7E5E FD94 D264 50DE 1CFC
> GPG key id: 50DE1CFC
> GPG public key: http://tux.creighton.edu/~pbrutsch/gpg-public-key.asc
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.0.4 (GNU/Linux)
> Comment: For info see http://www.gnupg.org
> 
> iD8DBQE6oEie/ZTSZFDeHPwRAg4UAKChgEkHgE84Q1OWsB5faZczFrFLjACdGkul
> sViRgWXfFAlKa3W9V8+RAYs=
> =wkJl
> -----END PGP SIGNATURE-----
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


Jesse Wyant - jrwyant@frx774.dhs.org
------------------------------------------------------------
I never met a man I didn't want to fight.
		-- Lyle Alzado, professional football lineman

