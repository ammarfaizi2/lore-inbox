Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbTHUBrq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 21:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbTHUBrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 21:47:46 -0400
Received: from proxyip3.us.army.mil ([140.183.234.117]:97 "EHLO
	mailrouter.us.army.mil") by vger.kernel.org with ESMTP
	id S262375AbTHUBro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 21:47:44 -0400
Date: Thu, 21 Aug 2003 10:39:19 +0900
From: kenton.groombridge@us.army.mil
Subject: Re: nforce2 lockups
To: linux-kernel@vger.kernel.org
Message-id: <2224f3e221f996.221f9962224f3e@us.army.mil>
MIME-version: 1.0
X-Mailer: iPlanet Messenger Express 5.2 HotFix 1.17 (built Jun 23 2003)
Content-type: text/plain; charset=us-ascii
Content-language: en
Content-transfer-encoding: 7BIT
Content-disposition: inline
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I downloaded and applied the acpi patch patch_2.4.22-rc2_to_acpi-2.4-20030813.bz2 from:

http://sourceforge.net/project/showfiles.php?group_id=36832

and it did cure my spurious interrupt problem, but unfortunately, my lockups have returned.

It is strange that kernel 2.4.22-rc2 had never locked up at all (only with apic enabled).  Ran it for a good week or so with absolutely no lockup (again, only with apic enabled).  I tried my best to make it lockup and it never did, but the spurious interrupts made any device that loaded with IRQ 16 and above pretty much worthless.  If I disabled apic, my lockups returned.

So there was something about 2.4.22-rc2 (with acpi enabled), that prevented lockups (but had tons os spurious interrupts).  Something in patch_2.4.22-rc2_to_acpi-2.4-20030813.bz2 cured the spurious interrupts, but brought back the lockups.

Ken Groombridge

----- Original Message -----
> > I have ASUS A7N8X Deluxe mobo with nForce2 rev 162 without any 
> problems> (if not counting unability to enabe SiI SATA DMA mode 
> with attached
> > Seagate Barracuda drive).
> 
> I have the exact same Board (except I'm not using SATA), and it's 
> a nightmare. 
> Best uptime so far: a little more than 16 hours. Usually it locks 
> up a lot 
> earlier. When I do network transfers I can cause it to lock within 
> a few 
> minutes. Under "the other OS" it runs without any problems.
> 
> - -- 
> Patrick Dreker

