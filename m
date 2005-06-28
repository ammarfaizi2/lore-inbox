Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbVF1P1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbVF1P1W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 11:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVF1P1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 11:27:22 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:18186 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S261987AbVF1P1Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 11:27:16 -0400
Message-ID: <42C16C1F.20202@stud.feec.vutbr.cz>
Date: Tue, 28 Jun 2005 17:26:23 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050603)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Steven Rostedt <rostedt@goodmis.org>, Daniel Walker <dwalker@mvista.com>,
       Chuck Harding <charding@llnl.gov>,
       Linux Kernel Discussion List <linux-kernel@vger.kernel.org>
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
References: <20050608112801.GA31084@elte.hu> <20050625091215.GC27073@elte.hu> <200506250919.52640.gene.heskett@verizon.net> <200506251039.14746.gene.heskett@verizon.net> <Pine.LNX.4.63.0506271157200.8605@ghostwheel.llnl.gov> <1119902991.4794.5.camel@dhcp153.mvista.com> <Pine.LNX.4.58.0506280337390.24849@localhost.localdomain> <20050628081843.GA16455@elte.hu> <20050628091222.GA30629@elte.hu>
In-Reply-To: <20050628091222.GA30629@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------080509040101010000000909"
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080509040101010000000909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> i've also uploaded -50-27 in which i've improved the irq-flags debugging 
> code.

Hi Ingo,
check_raw_flags needs to be exported. The attached one-line patch is 
against -V0.7.50-29.

Michal

--------------080509040101010000000909
Content-Type: text/plain;
 name="rt-check_raw_flags-export.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rt-check_raw_flags-export.diff"

--- linux-RT.mich/kernel/rt.c.orig	2005-06-28 17:20:18.000000000 +0200
+++ linux-RT.mich/kernel/rt.c	2005-06-28 17:14:19.000000000 +0200
@@ -2088,6 +2088,7 @@ void check_raw_flags(unsigned long flags
 		}
 	}
 }
+EXPORT_SYMBOL(check_raw_flags);
 
 static void check_soft_flags(unsigned long flags)
 {

--------------080509040101010000000909--
