Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266875AbUGVScZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266875AbUGVScZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 14:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266879AbUGVScZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 14:32:25 -0400
Received: from ss1000.ms.mff.cuni.cz ([195.113.20.8]:57487 "EHLO
	ss1000.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266875AbUGVScV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 14:32:21 -0400
Date: Thu, 22 Jul 2004 20:32:18 +0200
From: Rudo Thomas <rudo@matfyz.cz>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: voluntary-preempt I0: sluggish feel
Message-ID: <20040722183218.GA5907@ss1000.ms.mff.cuni.cz>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org
References: <20040721183010.GA2206@yoda.timesys> <20040721210051.GA2744@yoda.timesys> <20040721211826.GB30871@elte.hu> <20040721223749.GA2863@yoda.timesys> <20040722100657.GA14909@elte.hu> <20040722160055.GA4837@ss1000.ms.mff.cuni.cz> <20040722161941.GA23972@elte.hu> <20040722172428.GA5632@ss1000.ms.mff.cuni.cz> <20040722175457.GA5855@ss1000.ms.mff.cuni.cz> <20040722180142.GC30059@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040722180142.GC30059@elte.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Oh, sorry for the noise. It was the NVIDIA driver. The open one works
> > much better with the I0 patch.
> 
> i can reproduce this and i dont have the NVIDIA driver. When logging in
> over the network then shell output is chunky with a setting of 2
> (softirq redirection), shell output is smooth with a value of 1.

(Yes, you are right. The bad binary driver just makes it more visible.)

With untainted kernel, I was able to make xmms skip simply by switching virtual
desktops quickly enough.

When ksoftirqd was reniced to zero, it seems to perform fine (at "2" setting).

I would like to ask whether I should do this. Or is it just the other way round
- renicing the ksoftirqd thread "kills" the effect of deferred processing?

Thanks.

Rudo.
