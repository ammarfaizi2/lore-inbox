Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265766AbTGDD6Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 23:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265771AbTGDD6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 23:58:16 -0400
Received: from swan.mail.pas.earthlink.net ([207.217.120.123]:17797 "EHLO
	swan.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S265766AbTGDD6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 23:58:09 -0400
Subject: Re: 2.5.74-mm1 and Con Kolivas' CPU scheduler work
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: "ismail (cartman) donmez" <kde@myrealbox.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200307041229.06238.kernel@kolivas.org>
References: <200307031936.34458.kde@myrealbox.com>
	 <200307040949.18588.kernel@kolivas.org>
	 <1057284551.1725.8.camel@iso-8590-lx.zeusinc.com>
	 <200307041229.06238.kernel@kolivas.org>
Content-Type: text/plain
Organization: 
Message-Id: <1057291914.5681.11.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 04 Jul 2003 00:11:55 -0400
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-4.3, required 10,
	AWL, EMAIL_ATTRIBUTION, IN_REP_TO, REFERENCES, SPAM_PHRASE_02_03)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-03 at 22:29, Con Kolivas wrote:
> Ah yes I believe I know this issue. The problem is the parent spinning madly 
> waiting for the child and it is the parent that starves the child. While this 
> is not a fix, if you can reproduce the problem can you try changing 
> CHILD_PENALTY in kernel/sched.c from 50 to 100 and see if that makes the 
> problem go away? I mentioned this hidden in a thread a while ago, and am 
> trying to get a reasonable fix.

Well, perhaps I spoke too soon about this particular issues.  I have
just compiled 2.5.74-mm1 and it seems to be much better behaved that my
previous kernel (2.5.72-mm2).  I can no longer reproduce the issue with
this new kernel but the problem is easily reproducible with my older
kernel.  Does 2.5.74-mm1 have a recent version of your patches (I know
it has some variation of your patches but you've been cracking them out
pretty quick lately).  I've run testing with my horror cases of
Crossover Plugin and multiple Crossover Office applications running
simultaneously and all programs seem responsive, these cases caused all
kinds of audio skipping and pauses on the system before.

I'm still running some other tests that seem to be showing some
strangeness but I need to do some more test on both kernels before I
really reports them.

Thanks for your hard work on these issues, for my workload things seem
to be getting quite a bit better.

Later,
Tom


