Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267480AbUHSWbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267480AbUHSWbK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 18:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267484AbUHSWbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 18:31:10 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:42948 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267480AbUHSWbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 18:31:06 -0400
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
From: Lee Revell <rlrevell@joe-job.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20040819193049.GA13070@thunk.org>
References: <20040809104649.GA13299@elte.hu>
	 <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu>
	 <1092374851.3450.13.camel@mindpipe> <1092375673.3450.15.camel@mindpipe>
	 <20040813103151.GH8135@elte.hu>
	 <1092699974.13981.95.camel@krustophenia.net>
	 <20040817074826.GA1238@elte.hu> <20040817191819.GA19449@thunk.org>
	 <1092914397.830.3.camel@krustophenia.net>
	 <20040819193049.GA13070@thunk.org>
Content-Type: text/plain
Message-Id: <1092954744.830.23.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 19 Aug 2004 18:32:24 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-19 at 15:30, Theodore Ts'o wrote:
> On Thu, Aug 19, 2004 at 07:19:58AM -0400, Lee Revell wrote:
> > > I doubt SHA_CODE_SIZE will make a sufficient difference to avoid the
> > > latency problems.  What we would need to do is to change the code so
> > > that the rekey operation in __check_and_rekey takes place in a
> > > workqueue.  Say, something like this (warning, I haven't tested this
> > > patch; if it breaks, you get to keep both pieces):
> > > 
> > 
> > Tested, works for me.  This should probably be pushed upstream, as well
> > as added to -P5, correct?  Is there any disadvantage to doing it this
> > way?
> 
> Great, I will be pushing this upstream very shortly.
> 

Hmm, turns out that this does not fix the problem:

http://krustophenia.net/testresults.php?dataset=2.6.8.1-P4#/var/www/2.6.8.1-P4/extract_entropy_latency_trace.txt

Lee

