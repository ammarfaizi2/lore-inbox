Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262810AbTCSAw5>; Tue, 18 Mar 2003 19:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262854AbTCSAw5>; Tue, 18 Mar 2003 19:52:57 -0500
Received: from air-2.osdl.org ([65.172.181.6]:38823 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262810AbTCSAw4>;
	Tue, 18 Mar 2003 19:52:56 -0500
Subject: Re: [PATCH] boot time parameter to turn of TSC usage
From: Stephen Hemminger <shemminger@osdl.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, johnstul@us.ibm.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jerry Cooperstein <coop@axian.com>
In-Reply-To: <20030318163902.2572ab6f.akpm@digeo.com>
References: <20030318190557.GA14447@p3.attbi.com>
	 <1048019543.6294.3.camel@dell_ss3.pdx.osdl.net>
	 <20030318205907.GB4081@p3.attbi.com>
	 <200303182340.h2INeE4r098586@northrelay04.pok.ibm.com>
	 <20030319002119.GA5351@p3.attbi.com>
	 <1048034299.6296.85.camel@dell_ss3.pdx.osdl.net>
	 <20030318163902.2572ab6f.akpm@digeo.com>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1048035829.6297.105.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 18 Mar 2003 17:03:49 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-18 at 16:39, Andrew Morton wrote:
> Stephen Hemminger <shemminger@osdl.org> wrote:
> >
> > For machines that don't want to cooperate and have bad TSC counter and/or
> > change CPU frequency without change support.
> > 
> > This fixes the problem on Jerry Cooperstein's PIII laptop.
> > Could be useful for other people and tech support situations.
> 
> Is there no way in which this can be auto-detected?

Will leave that for someone with more direct knowledge access to
the chipset info.

> 
> > +__setup("notsclock", tsc_noclock_setup);
> 
> People have recently worked to make Documentation/kernel-parameters.txt
> relatively up-to-date.  Please try to remember to keep it in sync...
> 

--- kernel-parameters.txt.orig	2003-03-18 08:36:39.000000000 -0800
+++ kernel-parameters.txt.new	2003-03-18 17:01:32.000000000 -0800
@@ -627,7 +627,12 @@
 
 	nosync		[HW,M68K] Disables sync negotiation for all devices.
 
-	notsc		[BUGS=IA-32] Disable Time Stamp Counter
+	notsc		[BUGS=IA-32] Disable Time Stamp Counter.
+			Turns off TSC in processor. Kernel must
+			be compiled without TSC support.
+	
+	notsclock	[BUGS=IA-32] Tells kernel not to use 
+			Time Stamp Counter for gettimeofday. 
 
 	nousb		[USB] Disable the USB subsystem
 



