Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbWC2Mcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWC2Mcg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 07:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWC2Mcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 07:32:36 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:706 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751066AbWC2Mcg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 07:32:36 -0500
Date: Wed, 29 Mar 2006 14:29:59 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Esben Nielsen <simlo@phys.au.dk>, linux-kernel@vger.kernel.org
Subject: Re: PI patch against 2.6.16-rt9
Message-ID: <20060329122959.GA5175@elte.hu>
References: <Pine.LNX.4.44L0.0603290006290.32655-100000@lifa02.phys.au.dk> <1143590363.5344.257.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1143590363.5344.257.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.6
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.6 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.7 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> Btw, your get/put_task proposal adds two atomic ops. Atomic ops are 
> implicit memory barriers and therefor you add two extra slow downs 
> into the non conflict case.

i'm not that worried about this - the atomic ops are for already cached 
cachelines, any sane CPU ought to execute them close to full speed.  
(x86-ish cpus certainly do)

	Ingo
