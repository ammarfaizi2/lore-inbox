Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265823AbUIIUdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbUIIUdR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 16:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266821AbUIIU3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 16:29:50 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:45020 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S265823AbUIIU1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 16:27:50 -0400
Subject: Re: 2.6.9-rc1-mm4 kjournald oops (repeatable)
From: Lee Revell <rlrevell@joe-job.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Bongani Hlope <bonganilinux@mweb.co.za>,
       Richard A Nelson <cowboy@debian.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1094761240.3047.12.camel@sisko.scot.redhat.com>
References: <Pine.LNX.4.58.0409071707100.6982@onaqvg-unyy.qla.jronurnq.voz.pbz>
	 <20040908020402.3823a658.akpm@osdl.org>
	 <1094635403.1985.12.camel@sisko.scot.redhat.com>
	 <Pine.LNX.4.58.0409081011170.7419@hygvzn-guhyr.pnirva.bet>
	 <Pine.LNX.4.58.0409081604060.6248@hygvzn-guhyr.pnirva.bet>
	 <1094685396.1362.245.camel@krustophenia.net>
	 <Pine.LNX.4.58.0409081644150.6248@hygvzn-guhyr.pnirva.bet>
	 <20040909215611.47484cd8@localhost>
	 <1094761240.3047.12.camel@sisko.scot.redhat.com>
Content-Type: text/plain
Message-Id: <1094761676.1362.309.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 09 Sep 2004 16:27:57 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 16:20, Stephen C. Tweedie wrote:
> Hi,
> 
> On Thu, 2004-09-09 at 22:56, Bongani Hlope wrote:
> 
> > Ok it seem I'm not the only one. Ive bee trying to find this for a
> > while. It seems to happen on 2.6.9rc1-mm[24] kernels (I haven't tried
> > mm[13] ). I was only able to capture the Oops this morning (pen and
> > paper) I also have preempt enabled. This only happens on my PII though
> > (Mandrake cooker updates and kernel compiles), my dual opteron has
> > been running this since last night without any problems (gentoo sync
> > and kernel compile), also with preempt 
> 
> The journal_clean_checkpoint_list-latency-fix.patch was added in
> 2.6.9rc1-mm2 and is still there in mm4, so your problem is also
> consistent with a bug in that patch; could you try backing that one diff
> out and seeing if it fixes it for you too?
> 

This is not in fact the same journal_clean_checkpoint latency fix that
is in the VP patches, looks like that one is just a simple lock break. 
So, disregard my previous comment, all the evidence does in fact point
to journal_clean_checkpoint_list-latency-fix.patch.

Lee

