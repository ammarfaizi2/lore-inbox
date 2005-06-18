Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbVFRN4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbVFRN4R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 09:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbVFRN4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 09:56:17 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:55769 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262116AbVFRN4O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 09:56:14 -0400
Date: Sat, 18 Jun 2005 15:57:52 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20050618135752.GB19838@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Bill Davidsen <davidsen@tmr.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org> <20050607091144.GA5701@linuxtv.org> <20050608111503.GA5777@linuxtv.org> <42A6D521.606@ens-lyon.org> <20050608113718.GA5949@linuxtv.org> <42B30CE9.4050707@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42B30CE9.4050707@tmr.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: 84.189.217.46
Subject: Re: Linux v2.6.12-rc6
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> Johannes Stezenbach wrote:
> >Brice Goglin wrote:
> >>Johannes Stezenbach a écrit :
> >>>Indeed SMT works fine if I enable ACPI.
> >>>Is SMT without ACPI not supported?
> >>
> >>You can pass acpi=ht into the kernel command line to disable
> >>ACPI except the minimum required to get HT support.
> >
> >
> >That's nice, but I was thinking along the lines of:
> >
> >diff -ur linux-2.6.12-rc6.orig/arch/i386/Kconfig 
> >linux-2.6.12-rc6/arch/i386/Kconfig
> >--- linux-2.6.12-rc6.orig/arch/i386/Kconfig	2005-06-06 
> >23:16:27.000000000 +0200
> >+++ linux-2.6.12-rc6/arch/i386/Kconfig	2005-06-08 
> >13:35:08.000000000 +0200
> >@@ -503,7 +503,7 @@
> > 
> > config SCHED_SMT
> > 	bool "SMT (Hyperthreading) scheduler support"
> >-	depends on SMP
> >+	depends on SMP && ACPI
> > 	default off
> > 	help
> > 	  SMT scheduler support improves the CPU scheduler's decision making
> >
> >Comments? Is this intended?
> 
> I would think that you can't do HT without ACPI, so there's no point in 
> building in HT scheduling unless you can have HT.
> 
> Is that what you were asking? I was hoping someone else would comment.

In 2.6.12-rc5 SMT worked without CONFIG_ACPI. (IIRC the kernel used some
minimal ACPI stuff anyway for CPU initialisation).

I don't use power management or other features of ACPI so I
had it disabled, and my build broke with 2.6.12-rc6.

Johannes
