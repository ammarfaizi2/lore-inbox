Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288666AbSADPfr>; Fri, 4 Jan 2002 10:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288674AbSADPfh>; Fri, 4 Jan 2002 10:35:37 -0500
Received: from Expansa.sns.it ([192.167.206.189]:52754 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S288666AbSADPf2>;
	Fri, 4 Jan 2002 10:35:28 -0500
Date: Fri, 4 Jan 2002 16:34:53 +0100 (CET)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Andreas Schwab <schwab@suse.de>, Erik Andersen <andersen@codepoet.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: LSB1.1: /proc/cpuinfo
In-Reply-To: <20020104080358.A11215@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0201041629420.31357-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Jan 2002, Eric S. Raymond wrote:

> Andreas Schwab <schwab@suse.de>:
> > |> I'm not very worried about this.  On modern machines int == long
> >
> > You mean alpha, ia64, ppc64, s390x, x68-64 are not modern machines?
>
> Well, S390 certainly isn't! :-)
>
> If the PPC etc. have 32-bit ints then I stand corrected, but I thought the
> compiler ports on those machines used the native register size same as
> everybody else.
No, and the last troubles I had with reiserFS on sparc64 were exaclty
because of this.
in 2.4.17 s_properties is declared as unsigned int, while it should be
an unsigned long. On x86 that is not aproblem at all, on all 64 bits CPUs
reiserFS is unusable if you do not make a little patch.


