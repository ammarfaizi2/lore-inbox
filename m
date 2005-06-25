Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVFYSI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVFYSI2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 14:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVFYSI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 14:08:28 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:6086 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261223AbVFYSI0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 14:08:26 -0400
Subject: Re: 2.6.12-mm1 boot failure on NUMA box.
From: Lee Revell <rlrevell@joe-job.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Con Kolivas <kernel@kolivas.org>
In-Reply-To: <44570000.1119681732@[10.10.2.4]>
References: <20050621130344.05d62275.akpm@osdl.org>
	 <51900000.1119622290@[10.10.2.4]> <20050624170112.GD6393@elte.hu>
	 <320710000.1119632967@flay> <20050624195248.GA9663@elte.hu>
	 <344410000.1119646572@flay> <20050625040052.GB4800@elte.hu>
	 <44570000.1119681732@[10.10.2.4]>
Content-Type: text/plain
Date: Sat, 25 Jun 2005 14:08:25 -0400
Message-Id: <1119722905.5762.15.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-24 at 23:42 -0700, Martin J. Bligh wrote:
> > (btw., if the TSC is that unreliable on numaq boxes, shouldnt we disable 
> > it for userspace apps too? Or are those hangs purely kernel bugs? In 
> > which case it might make sense to debug those a bit more - large-scale 
> > TSC unsyncedness is something that could slip in on other hardware too.)
> 
> Well it reads reliably. it just reliably reads utter random crap (well,
> across CPUs). Not many things read tsc from userspace, and it won't hang
> I guess .... depends what their expecations are. I do like gettimeofday
> not to go backwards though - that tends to bugger things up ;-)

The userspace apps that read the TSC know what they are doing, and have
chosen to use the TSC because they need a cheap, fast timer rather than
a correct one.  Please don't break it.

Lee

