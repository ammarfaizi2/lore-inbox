Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUAWPw2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 10:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbUAWPw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 10:52:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:47847 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261875AbUAWPw1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 10:52:27 -0500
Date: Fri, 23 Jan 2004 07:51:51 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] local APIC LVTT init bug
In-Reply-To: <Pine.LNX.4.55.0401231419460.3223@jurand.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.58.0401230748080.2151@home.osdl.org>
References: <16400.9569.745184.16182@alkaid.it.uu.se>
 <Pine.LNX.4.55.0401231250310.3223@jurand.ds.pg.gda.pl>
 <16401.6720.115695.872847@alkaid.it.uu.se> <Pine.LNX.4.55.0401231419460.3223@jurand.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 23 Jan 2004, Maciej W. Rozycki wrote:
> On Fri, 23 Jan 2004, Mikael Pettersson wrote:
> > 
> > The ASUS L3800C was mentioned. I don't know of any others.
> 
>  It seems to be P4-based -- I'm pretty sure the integrated APIC behaves
> the same way regardless of where its plugged in, so why wouldn't this
> problem appear earlier?

It's entirely possible that the bug isn't in the integrated APIC per se, 
but migth be in ACPI/SMM getting confused when it reads the LVTT value and
tries to do something with it. And since the system vendors don't tend
to test with Linux (or test only with a few standard kernels that may not 
even have APIC enabled) the code might never have been tested with that 
behaviour.

Now quite honestly, I don't know _why_ it would read the value, so that 
theory is a pretty weak one, but the point being that it's not absolutely 
necessary that the hardware itself be broken. This is the reason we see
most SMM/BIOS bugs - the code just assumes certain states.

		Linus
