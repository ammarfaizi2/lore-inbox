Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267299AbSLEMFU>; Thu, 5 Dec 2002 07:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267301AbSLEMFU>; Thu, 5 Dec 2002 07:05:20 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:18950 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S267299AbSLEMFT>; Thu, 5 Dec 2002 07:05:19 -0500
Date: Thu, 5 Dec 2002 13:12:50 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Chris Adams <cmadams@hiwaay.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: #! incompatible -- binfmt_script.c broken?
Message-ID: <20021205121250.GE15405@merlin.emma.line.org>
Mail-Followup-To: Chris Adams <cmadams@hiwaay.net>,
	linux-kernel@vger.kernel.org
References: <20021204205945.A233182@hiwaay.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021204205945.A233182@hiwaay.net>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Dec 2002, Chris Adams wrote:

> Try the following under your shell.  On Solaris and Tru64 sh and ksh, it
> is handled with no error.  Under bash (on Linux, Solaris, and Tru64), it
> returns an error:
> 
> $ set "-- xyzzy"
> $ echo $?
> 
> According to SUSv3, bash is not compliant, because for set, under the
> section "CONSEQUENCES OF ERRORS" is listed "None." and the "EXIT STATUS"
> is "Zero."

> Fix the shell(s).

That's correct. But how do you derive that the sh command line must
behave the same? The sh command is not the sh special built-in.

However, it would be reasonable if a /bin/sh set $1 to be "-- xyzzy" if
a file "foo" with

#! /bin/sh -- xyzzy

was executed (as path = [/bin/sh] argv = [./foo] [-- xyzzy]);
and although I didn't check, I wonder how shells without the "--" long
options parse that line.
