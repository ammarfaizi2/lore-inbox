Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbVJLBVG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbVJLBVG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 21:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932389AbVJLBVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 21:21:06 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:9130 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932388AbVJLBVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 21:21:05 -0400
Subject: Re: Latency data - 2.6.14-rc3-rt13
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <5bdc1c8b0510111809v2609879ai8aa0a8e283acb58d@mail.gmail.com>
References: <5bdc1c8b0510101316k23ff64e2i231cdea7f11e8553@mail.gmail.com>
	 <1128980674.18782.211.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <5bdc1c8b0510101509w4c74028apb6e69746b1b8b65b@mail.gmail.com>
	 <1128983301.18782.215.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <5bdc1c8b0510101633lc45fbf8gd2677e5646dc6f93@mail.gmail.com>
	 <5bdc1c8b0510101649s221ab437scc49d6a49269d6b@mail.gmail.com>
	 <5bdc1c8b0510102045u7e4bc9eeld5b690b5e96c4a5f@mail.gmail.com>
	 <20051011111700.GA15892@elte.hu>
	 <5bdc1c8b0510111545n29b77010h8558a1b69c4bf12a@mail.gmail.com>
	 <1129075368.7094.3.camel@mindpipe>
	 <5bdc1c8b0510111809v2609879ai8aa0a8e283acb58d@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 11 Oct 2005 21:21:01 -0400
Message-Id: <1129080062.7094.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-11 at 18:09 -0700, Mark Knecht wrote:
> Should free memory drop like that over time?

Yes this is perfectly normal.  When a system first boots all the memory
your apps aren't using is initially free.  As applications access more
data over time then it will be cached in memory until free memory drops
to near zero.

"Free memory" is actually wasted memory - it's better to use all
available RAM for caching.

Lee

