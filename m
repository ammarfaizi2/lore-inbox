Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284009AbRLTKed>; Thu, 20 Dec 2001 05:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284037AbRLTKeY>; Thu, 20 Dec 2001 05:34:24 -0500
Received: from p0029.as-l043.contactel.cz ([194.108.242.29]:1284 "EHLO devix")
	by vger.kernel.org with ESMTP id <S284009AbRLTKeN>;
	Thu, 20 Dec 2001 05:34:13 -0500
Date: Thu, 20 Dec 2001 11:30:21 +0100 (CET)
From: devik <devik@cdi.cz>
X-X-Sender: <devik@devix>
To: Robert Love <rml@tech9.net>
cc: Chris Meadors <clubneon@hereintown.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: gcc 3.0.2/kernel details (-O issue)
In-Reply-To: <1008792213.806.36.camel@phantasy>
Message-ID: <Pine.LNX.4.33.0112201115030.626-100000@devix>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, you certainly won't get errors, because compiler optimizations
> shouldn't change expected syntax.

not always true, inb() doesn't compile without -O for example.

> -O2 is the standard optimization level for the kernel; everything is
> compiled via it.  When developers test their code, nuances that the
> optimization introduce are accepted.  Removing the optimization may
> break those expectations.  Thus the kernel requires it.

I'm quite comfortable with the requirement, only I can't imagine
code which depends on -O and -O2 difference. Inline assembly is
handled by compiler so it should not break things ..
Maybe externaly linked assembly code ? But optimization level should
not change register usage in calling convention ..
Please can you give me example which kind of code breaks those
expectations ?

Thanks, Martin

