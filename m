Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTDUVzd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 17:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262599AbTDUVzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 17:55:33 -0400
Received: from zero.aec.at ([193.170.194.10]:57352 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262577AbTDUVz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 17:55:29 -0400
Date: Tue, 22 Apr 2003 00:07:15 +0200
From: Andi Kleen <ak@muc.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@muc.de>, Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix CPU Names in Kconfig
Message-ID: <20030421220715.GA14573@averell>
References: <20030421205520.GA13940@averell> <1050955686.13841.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1050955686.13841.0.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 10:08:07PM +0200, Alan Cox wrote:
> On Llu, 2003-04-21 at 21:55, Andi Kleen wrote:
> > OldXeon for the P3 based Xeons is a bit confusing, but we cannot 
> > fix the Intel marchitecture here.
> 
> "Pentium II/III Xeon" v "Pentium IV Xeon"
> 
> At least thats what ebay user seem to use to distinguish 8)

The reason I didn't do it is that it cannot be easily typed
in make oldconfig / make config

(but it probably should offer an numeric menu for these cases I guess...) 

Fixed version for Linus.

diff -u linux-2.5.68-gencpu/arch/i386/Kconfig-o linux-2.5.68-gencpu/arch/i386/Kconfig
--- linux-2.5.68-gencpu/arch/i386/Kconfig-o	2003-04-20 21:24:16.000000000 +0200
+++ linux-2.5.68-gencpu/arch/i386/Kconfig	2003-04-22 00:06:44.000000000 +0200
@@ -183,7 +183,7 @@
 	  optimizations.
 
 config MPENTIUMIII
-	bool "Pentium-III/Celeron(Coppermine)"
+	bool "Pentium-III/Celeron(Coppermine)/Pentium III Xeon"
 	help
 	  Select this for Intel chips based on the Pentium-III and
 	  Celeron-Coppermine core.  This option enables use of some
@@ -191,7 +191,7 @@
 	  extensions.
 
 config MPENTIUM4
-	bool "Pentium-4/Celeron(P4-based)"
+	bool "Pentium-4/Celeron(P4-based)/Pentium IV Xeon"
 	help
 	  Select this for Intel Pentium 4 chips.  This includes both
 	  the Pentium 4 and P4-based Celeron chips.  This option



