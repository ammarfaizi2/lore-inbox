Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266034AbUI0NP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUI0NP7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 09:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUI0NP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 09:15:58 -0400
Received: from dsl254-100-205.nyc1.dsl.speakeasy.net ([216.254.100.205]:57551
	"EHLO memeplex.com") by vger.kernel.org with ESMTP id S264953AbUI0NP4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 09:15:56 -0400
From: "Andrew A." <aathan-linux-kernel-1542@cloakmail.com>
To: "Jan Kara" <jack@suse.cz>,
       "Andrew A." <aathan-linux-kernel-1542@cloakmail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Consistent kernel hang during heavy TCP connection handling load
Date: Mon, 27 Sep 2004 09:15:20 -0400
Message-ID: <OMEGLKPBDPDHAGCIBHHJKEBPEJAA.aathan-linux-kernel-1542@cloakmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <20040927082410.GB16869@atrey.karlin.mff.cuni.cz>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jan/all:

Yes, I have reproduced the problem on another machine running a similar kernel but with different network card, CPU, etc.

A.

-----Original Message-----
From: Jan Kara
Subject: Re: Consistent kernel hang during heavy TCP connection handling
load


  Hello,

> Thanks for responding.  When I got no responses, I searched for ways
  I don't have personaly much experience with debugging by above tools
so I won't be of much help. As you describe the problem below I
personaly think that you won't get much from them if the system is as
unresponsive as you write.

> (3) Enabled sysrq on both kernels, including echo "1" > /proc/sys/kernel/sysrq
> 
> I'll wait for the next hang now, trying it on both kernels.  By the
> way, the system is hung VERY badly--doesn't respond to anything, no
> switching consoles, no keyboard events, no disk activity.  Dunno about
> network, since I haven't put a sniffer on it yet.
  Hmm.. that looks bad. Do you debug things under console and not
in X? If that is the case either there is some hardware problem (you
likely generate quite high load on the machine) or some driver is stuck
with interrupts disabled. In case debugging tools don't help you can try
to compile kernel with minimal config (just disable everything not
needed to run the test). Also reproducing on a different machine would
be useful to rule out hardware...

								Honza




