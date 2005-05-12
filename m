Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261197AbVELHpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVELHpK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 03:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261219AbVELHpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 03:45:10 -0400
Received: from pop.gmx.net ([213.165.64.20]:12248 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261197AbVELHpA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 03:45:00 -0400
Date: Thu, 12 May 2005 09:44:59 +0200 (MEST)
From: "Manfred Schwarb" <manfred99@gmx.ch>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <20050511231016.GC18600@alpha.home.local>
Subject: Re: 2.4.30-hf1 do_IRQ stack overflows
X-Priority: 3 (Normal)
X-Authenticated: #17170890
Message-ID: <16624.1115883899@www69.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 
> > Hi,
> > with recent versions of the 2.4 kernel (Vanilla), I get an increasing 
> > amount of do_IRQ stack overflows.
> > This night, I got 3 of them.
> > With 2.4.28 I got an overflow about twice a year, with 2.4.29 nearly 
> > once a month and with 2.4.30 nearly every day 8-((
> 
> stupid question : have you tried reverting to older versions to check
> if the problem follows kernel upgrades or if something is ageing badly
> in your machine ?
> 
No, I have not, and I think I will not find the needed time to fully 
track it down.

> > My layout: Pentium4 HT SMP, raid1 on a promise card, driven by 
> > libata_promise, everything using reiserfs, heavy nfs and network
> traffic, 
> > with a Linksys (tulip) and a Realtek (8139too) NIC.
> 
> do you mean that you tested both with tulip and realtek and that the
> problem happens with both of them, or that your machine needs those
> two NICs simultaneously ? Using a realtek with heavy NFS and network
> traffic seems somewhat odd, eventhough the driver is rather stable.
> 
both simultaneously. I thought the realtek is enough for the internet
connection, as the bottleneck clearly is the ISP (we have a 10Mb/s wire).
"heavy" is relative, a few handful (<20) of concurrent connections.
the other NIC is the connection to the internal network.

> > The used 2.4.30-hf1 is pure Vanilla.
> > 
> > Below my three overflow messages. Would the stack reduction patches of 
> > Badari Pulavarty help in my case? 
> 
> I don't know. I suspect that it might delay the problem but not remove
> it.
> 
> Regards,
> Willy
> 
Thanks,
Manfred

-- 
+++ Neu: Echte DSL-Flatrates von GMX - Surfen ohne Limits +++
Always online ab 4,99 Euro/Monat: http://www.gmx.net/de/go/dsl
