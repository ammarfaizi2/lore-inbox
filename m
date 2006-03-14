Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932082AbWCNX1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932082AbWCNX1k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 18:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWCNX1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 18:27:40 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:15330 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932082AbWCNX1k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 18:27:40 -0500
Date: Wed, 15 Mar 2006 00:25:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: rmk+serial@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: soft lockup in serial8250_console_write(?)
Message-ID: <20060314232515.GA21782@elte.hu>
References: <20060314134110.3470fc63.rdunlap@xenotime.net> <20060314214049.GA29536@elte.hu> <20060314151812.2779ed4b.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060314151812.2779ed4b.rdunlap@xenotime.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Randy.Dunlap <rdunlap@xenotime.net> wrote:

> > > This function calls wait_for_xmitr() [inline], which in worst case can 
> > > spin for 1.010 seconds.  Could this be the cause of a soft lockup?
> > 
> > hm, it shouldnt cause that. Could you try the attached patch [which is 
> > the next-gen softlockup detector], do you get the message even with that 
> > one applied?
> 
> 5/5 good boots with your new patch.
> 5/5 soft lockups without it.
> 
> Is this scheduled for post-2.6.16 ?

yes, in theory. Andrew?

	Ingo
