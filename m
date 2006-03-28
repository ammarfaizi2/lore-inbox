Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWC1VFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWC1VFW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 16:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWC1VFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 16:05:22 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:57768 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932171AbWC1VFV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 16:05:21 -0500
Date: Tue, 28 Mar 2006 23:02:48 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: PI patch against 2.6.16-rt9
Message-ID: <20060328210248.GE1217@elte.hu>
References: <Pine.LNX.4.44L0.0603271501150.20599-100000@lifa03.phys.au.dk> <Pine.LNX.4.44L0.0603280002430.25351-100000@lifa03.phys.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0603280002430.25351-100000@lifa03.phys.au.dk>
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


* Esben Nielsen <simlo@phys.au.dk> wrote:

> My girl friend will be angry for me not being to bed yet, but I had to 
> steal time to make this patch. I hope I managed to send it without 
> white-space damage or anything like it.

thanks - this looks fine to me, but i'm still worried about the 
nonatomic chain boosting side-effects that i outlined in the previous 
mail.

the tempting property of your patch is the fundamental reschedulability 
of the boosting itself - and the resulting simplicity of locking. On the 
con side, i dont see how we can detect deadlocks reliably, nor how we 
can avoid 'incorrect boosting' (outlined in the previous mail), if the 
chain gets 'broken'.

	Ingo
