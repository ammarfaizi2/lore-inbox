Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267310AbSLEMmp>; Thu, 5 Dec 2002 07:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267311AbSLEMmp>; Thu, 5 Dec 2002 07:42:45 -0500
Received: from ns.suse.de ([213.95.15.193]:47621 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267310AbSLEMmo>;
	Thu, 5 Dec 2002 07:42:44 -0500
To: Chris Adams <cmadams@hiwaay.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: #! incompatible -- binfmt_script.c broken?
References: <20021204205945.A233182@hiwaay.net>
	<20021205121250.GE15405@merlin.emma.line.org>
X-Yow: Somewhere in suburban Honolulu, an unemployed bellhop is whipping up
 a batch of illegal psilocybin chop suey!!
From: Andreas Schwab <schwab@suse.de>
Date: Thu, 05 Dec 2002 13:50:18 +0100
In-Reply-To: <20021205121250.GE15405@merlin.emma.line.org> (Matthias
 Andree's message of "Thu, 5 Dec 2002 13:12:50 +0100")
Message-ID: <jebs40635h.fsf@sykes.suse.de>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.3.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> writes:

|> On Wed, 04 Dec 2002, Chris Adams wrote:
|> 
|> > Try the following under your shell.  On Solaris and Tru64 sh and ksh, it
|> > is handled with no error.  Under bash (on Linux, Solaris, and Tru64), it
|> > returns an error:
|> > 
|> > $ set "-- xyzzy"
|> > $ echo $?
|> > 
|> > According to SUSv3, bash is not compliant, because for set, under the
|> > section "CONSEQUENCES OF ERRORS" is listed "None." and the "EXIT STATUS"
|> > is "Zero."
|> 
|> > Fix the shell(s).
|> 
|> That's correct. But how do you derive that the sh command line must
|> behave the same? The sh command is not the sh special built-in.
|> 
|> However, it would be reasonable if a /bin/sh set $1 to be "-- xyzzy" if
|> a file "foo" with
|> 
|> #! /bin/sh -- xyzzy
|> 
|> was executed (as path = [/bin/sh] argv = [./foo] [-- xyzzy]);
|> and although I didn't check, I wonder how shells without the "--" long
|> options parse that line.

POSIX is quite clear about that: only "--" as a single argument is
defined, other uses are undefined.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
