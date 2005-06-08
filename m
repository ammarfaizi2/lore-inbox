Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262179AbVFHLi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262179AbVFHLi4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 07:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262177AbVFHLhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 07:37:48 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:16279 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262181AbVFHLf5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 07:35:57 -0400
Date: Wed, 8 Jun 2005 13:37:18 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20050608113718.GA5949@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Brice Goglin <Brice.Goglin@ens-lyon.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org> <20050607091144.GA5701@linuxtv.org> <20050608111503.GA5777@linuxtv.org> <42A6D521.606@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42A6D521.606@ens-lyon.org>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: 84.189.245.163
Subject: Re: Linux v2.6.12-rc6
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin wrote:
> Johannes Stezenbach a écrit :
> > Johannes Stezenbach wrote:
> > 
> >>Hype-threading stopped working for me (probably due to
> >>me not enabling ACPI). dmesg output and .config attached.
> >>-rc5 worked fine. The board is an Asus P4P800-Deluxe.
> >>
> >>dmesg: WARNING: 1 siblings found for CPU0, should be 2
> > 
> > 
> > Indeed SMT works fine if I enable ACPI.
> > Is SMT without ACPI not supported?
> 
> You can pass acpi=ht into the kernel command line to disable
> ACPI except the minimum required to get HT support.

That's nice, but I was thinking along the lines of:

diff -ur linux-2.6.12-rc6.orig/arch/i386/Kconfig linux-2.6.12-rc6/arch/i386/Kconfig
--- linux-2.6.12-rc6.orig/arch/i386/Kconfig	2005-06-06 23:16:27.000000000 +0200
+++ linux-2.6.12-rc6/arch/i386/Kconfig	2005-06-08 13:35:08.000000000 +0200
@@ -503,7 +503,7 @@
 
 config SCHED_SMT
 	bool "SMT (Hyperthreading) scheduler support"
-	depends on SMP
+	depends on SMP && ACPI
 	default off
 	help
 	  SMT scheduler support improves the CPU scheduler's decision making

Comments? Is this intended?

Johannes
