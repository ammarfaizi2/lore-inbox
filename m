Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269361AbUICIHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269361AbUICIHa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 04:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269368AbUICIH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 04:07:28 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:58802 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269361AbUICIFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 04:05:55 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R0
From: Lee Revell <rlrevell@joe-job.com>
To: Free Ekanayaka <free@agnula.org>
Cc: Ingo Molnar <mingo@elte.hu>, Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, luke@audioslack.com, free78@tin.it
In-Reply-To: <87acw7bxkh.fsf@agnula.org>
References: <20040902065549.GA18860@elte.hu> <20040902111003.GA4256@elte.hu>
	 <20040902215728.GA28571@elte.hu>
	 <1094162812.1347.54.camel@krustophenia.net>
	 <20040902221402.GA29434@elte.hu>
	 <1094171082.19760.7.camel@krustophenia.net>
	 <1094181447.4815.6.camel@orbiter>
	 <1094192788.19760.47.camel@krustophenia.net>
	 <20040903063658.GA11801@elte.hu>
	 <1094194157.19760.71.camel@krustophenia.net>
	 <20040903070500.GB13100@elte.hu>
	 <1094197233.19760.115.camel@krustophenia.net>  <87acw7bxkh.fsf@agnula.org>
Content-Type: text/plain
Message-Id: <1094198755.19760.133.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 03 Sep 2004 04:05:55 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-03 at 03:50, Free Ekanayaka wrote:
>   LR> As far as I am concerned the VP patches are stable enough for the
>   LR> audio-centric distros to start distributing VP kernel packages, these
>   LR> will certainly be using the vanilla kernel.  I think the PlanetCCRMA and
>   LR> AGNULA people are planning to start distributing test VP-kernel packages
>   LR> as soon as the patches stabilize.  IIRC Nando is on vacation this week.
> 
>   LR> I will make an announcement on LAD that as of R0 the VP patches should
>   LR> be stable and are ready for wider testing.  You may want to wait until
>   LR> after the initial slew of bug reports before rebasing VP against MM.  I
>   LR> suspect most of the problems with be driver specific, and most of the
>   LR> fixes will apply equally to -mm and vanilla.
> 
>   LR> I have added Luke (AudioSlack), Free (AGNULA), and Nando (CCRMA) to the
>   LR> cc: list.  They would be in the best position to answer your question.
> 
> Yes, you're right. We plan to  provide test 2.6.x  packages as soon as
> patches stabilise. Please let me  know if you have some recommendation
> (configuration flags, additional patches, etc.).
> 

As of -R0 it's definitely stable on UP and SMP users are reporting the
same.  All known problems should be fixed, and there are no known
regressions.  You should probably post a UP version and have your users
test that before posting SMP packages, the latter are not quite as well
tested.

No other patches (ie various scheduler tweaks, CK) should be necessary,
and in fact are not recommended because they might mask latency issues
that we would rather fix.

I use Debian unstable which should be pretty close to AGNULA, and for
several weeks now I have been unable to produce an xrun in jack at 32
frames no matter what I throw at the machine.  I actually have not had
xrun debugging enabled in weeks because I don't get any xruns.

Any problems at this point are most likely going to involve less common
hardware, stuff the LKML testers don't have.

Lee

