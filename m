Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265701AbUIIUZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265701AbUIIUZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 16:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbUIIUW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 16:22:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34012 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266821AbUIIUVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 16:21:06 -0400
Subject: Re: 2.6.9-rc1-mm4 kjournald oops (repeatable)
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Bongani Hlope <bonganilinux@mweb.co.za>
Cc: Richard A Nelson <cowboy@debian.org>, Lee Revell <rlrevell@joe-job.com>,
       Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <20040909215611.47484cd8@localhost>
References: <Pine.LNX.4.58.0409071707100.6982@onaqvg-unyy.qla.jronurnq.voz.pbz>
	 <20040908020402.3823a658.akpm@osdl.org>
	 <1094635403.1985.12.camel@sisko.scot.redhat.com>
	 <Pine.LNX.4.58.0409081011170.7419@hygvzn-guhyr.pnirva.bet>
	 <Pine.LNX.4.58.0409081604060.6248@hygvzn-guhyr.pnirva.bet>
	 <1094685396.1362.245.camel@krustophenia.net>
	 <Pine.LNX.4.58.0409081644150.6248@hygvzn-guhyr.pnirva.bet>
	 <20040909215611.47484cd8@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1094761240.3047.12.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Sep 2004 21:20:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2004-09-09 at 22:56, Bongani Hlope wrote:

> Ok it seem I'm not the only one. Ive bee trying to find this for a
> while. It seems to happen on 2.6.9rc1-mm[24] kernels (I haven't tried
> mm[13] ). I was only able to capture the Oops this morning (pen and
> paper) I also have preempt enabled. This only happens on my PII though
> (Mandrake cooker updates and kernel compiles), my dual opteron has
> been running this since last night without any problems (gentoo sync
> and kernel compile), also with preempt 

The journal_clean_checkpoint_list-latency-fix.patch was added in
2.6.9rc1-mm2 and is still there in mm4, so your problem is also
consistent with a bug in that patch; could you try backing that one diff
out and seeing if it fixes it for you too?

Thanks,
 Stephen

