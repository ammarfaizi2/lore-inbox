Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266547AbUAWNbh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 08:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266556AbUAWNbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 08:31:36 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:35723 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S266547AbUAWNbb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 08:31:31 -0500
Date: Fri, 23 Jan 2004 14:31:29 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] local APIC LVTT init bug
In-Reply-To: <16401.6720.115695.872847@alkaid.it.uu.se>
Message-ID: <Pine.LNX.4.55.0401231419460.3223@jurand.ds.pg.gda.pl>
References: <16400.9569.745184.16182@alkaid.it.uu.se>
 <Pine.LNX.4.55.0401231250310.3223@jurand.ds.pg.gda.pl>
 <16401.6720.115695.872847@alkaid.it.uu.se>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jan 2004, Mikael Pettersson wrote:

>  >  Sigh -- why can't designers keep such a trivial backwards
>  > compatibility???  The integrated APIC was said to be backwards compatible
>  > when introduced and so far all implementations used to.  What you write
>  > means that has been broken -- could please say which vendor to blame?
> 
> The ASUS L3800C was mentioned. I don't know of any others.

 It seems to be P4-based -- I'm pretty sure the integrated APIC behaves
the same way regardless of where its plugged in, so why wouldn't this
problem appear earlier?  I've browsed my mailbox and found a patch that
was stated to fix problems on the system involved.  But the patch disables
the timer around certain actions -- that may indeed matter for some broken
firmware (especially some SMM crap), but I can't see how these bits could.

 That doesn't of course mean your patch shouldn't be applied -- it won't 
hurt to be overly careful.

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
