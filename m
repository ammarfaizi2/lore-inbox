Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262076AbUCVQLf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 11:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbUCVQLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 11:11:35 -0500
Received: from chaos.analogic.com ([204.178.40.224]:44674 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262076AbUCVQLc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 11:11:32 -0500
Date: Mon, 22 Mar 2004 11:13:18 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Timothy Miller <miller@techsource.com>
cc: Tigran Aivazian <tigran@veritas.com>,
       David Schwartz <davids@webmaster.com>,
       Justin Piszcz <jpiszcz@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux Kernel Microcode Question
In-Reply-To: <405F0B8D.8040408@techsource.com>
Message-ID: <Pine.LNX.4.53.0403221057400.17797@chaos>
References: <Pine.LNX.4.44.0403191721110.3892-100000@einstein.homenet>
 <405F0B8D.8040408@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Mar 2004, Timothy Miller wrote:

>
>
> Tigran Aivazian wrote:
> > On Thu, 18 Mar 2004, David Schwartz wrote:
> >
> >>	It is at least theoeretically possible that a microcode update might cause
> >>an operation that's normally done very quickly (in dedicated hardware) to be
> >>done by a slower path (microcode operations) to fix a bug in the dedicated
> >>hardware
> >
> >
> > Did you dream that up or did you read it somewhere? If the latter, where?
> >
> > All operations are done by "dedicated hardware" and microcode DOES modify
> > that hardware, or rather the way instructions are "digested". So, applying
> > microcode doesn't make anything slower per se, it's just replacing one
> > code sequence with another code sequence. If a new code happens to be
> > slower than the old one then of course the result will be slower, but the
> > reverse is also true. When you fix a bug in a particular software why
> > should a bugfix be apriori slower than the original code? Think about it.
> >
> > So please do not spread misinformation that applying microcode makes
> > something slower. If anything, it should make things faster, as long as
> > the guys at Intel are writing the correct (micro)code.
>
> I don't see anything wrong with what he said.  As I understand it,
> Pentium 4 CPUs don't use microcode for much of anything.  If an
> instruction which was done entirely in dedicated hardware was buggy, and
> it's replaced by microcode, then it will most certainly be slower.

ALL instructions are performed by the microcode. If the microcode
that is loaded into the control-store upon reset is replaced by
microcode that is loaded later, why should it be slower? It is
possible that some control-sequence may be replaced with one that
takes fewer clocks, takes more clocks, or takes the same number of
clocks. If it takes the same number of clocks, there is no change.
If fewer, faster. If greater, slower. FYI, the WCS (Writable control-
store) goes back to Digital PDP-days (and VAXen). The CPU was a
board, not a chip. It was damn dumb upon power-up. A monitor program
in an 8085, loaded the microcode from a tape called the "console".

The WCS allows CPUs to be fixed permanently, if something is wrong,
with absolutely no negative trade-offs whatsoever.

>
> You seem to have missed where David used terms like "theoretically
> possible" and "an operation".

It is theoretically possible for me to win the Lottery tomorrow.
Since I haven't yet purchased a chance, it is unlikely.........
But chaos theory shows the probability is non-zero, even if I
don't purchase the chance. So, "theoretically" is one of those
words that can't be used to substantiate an argument.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


