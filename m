Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272900AbTG3OTx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 10:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272893AbTG3OTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 10:19:53 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:3821 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S272924AbTG3OTj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 10:19:39 -0400
Date: Wed, 30 Jul 2003 16:18:11 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: TSCs are a no-no on i386
In-Reply-To: <20030730135623.GA1873@lug-owl.de>
Message-ID: <Pine.GSO.3.96.1030730161309.911E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jul 2003, Jan-Benedict Glaw wrote:

> This small patch fixes a long-standing problem for bare i386 CPUs. These
> don't have TSCs and so, a recent 2.4.x kernel will simply halt the

 Actually i486 processors and some Pentium-like clones have none, too.

> machine leaving a text like "This CPU has no TSC feature (ie was
> compiled for Pentium+) but I do depend on it".

 That only happens if you change existing .config -- it may happen for all
options that are unset instead of being set to "n" -- and it can be worked
around by running `make oldconfig' twice. 

> Please apply. Worst to say, even Debian seems to start using i486+
> features (ie. libstdc++5 is SIGILLed on Am386 because there's no
> "lock" insn available)...

 You need the change for CONFIG_M486 and CONFIG_M586 as well.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

