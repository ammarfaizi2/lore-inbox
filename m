Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267681AbUJCCOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267681AbUJCCOU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 22:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267678AbUJCCOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 22:14:20 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:21165 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267681AbUJCCOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 22:14:12 -0400
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm4-S7
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "K.R. Foley" <kr@cybsft.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Joel White <cv223@comcast.net>
In-Reply-To: <1096768900.1375.26.camel@krustophenia.net>
References: <1094683020.1362.219.camel@krustophenia.net>
	 <20040909061729.GH1362@elte.hu> <20040919122618.GA24982@elte.hu>
	 <414F8CFB.3030901@cybsft.com> <20040921071854.GA7604@elte.hu>
	 <20040921074426.GA10477@elte.hu> <20040922103340.GA9683@elte.hu>
	 <20040923122838.GA9252@elte.hu> <20040923211206.GA2366@elte.hu>
	 <20040924074416.GA17924@elte.hu>  <20040928000516.GA3096@elte.hu>
	 <1096768900.1375.26.camel@krustophenia.net>
Content-Type: text/plain
Message-Id: <1096769650.1375.34.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 02 Oct 2004 22:14:10 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-02 at 22:01, Lee Revell wrote:
> On Mon, 2004-09-27 at 20:05, Ingo Molnar wrote:
> > i've released the -S7 VP patch:
> > 
> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc2-mm4-S7
> > 
> 
> I believe we have found a bug.  A user reported massive xruns with S7,
> they turned out to be printk() overhead from tons of "using
> smp_processor_id() in preemptible code" errors.  The trace below repeats
> over and over.  Looks like raid0 is the problem.

The exact configuration is 4 SCSI drives in a raid 0, and a single IDE
drive.  The raid0 code apparently is not preempt safe.

Lee

