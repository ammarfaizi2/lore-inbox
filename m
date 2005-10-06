Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbVJFRiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbVJFRiQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 13:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVJFRiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 13:38:16 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:21148 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751255AbVJFRiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 13:38:15 -0400
Subject: Re: 2.6.14-rc3-rt9 - a few xruns misses
From: Lee Revell <rlrevell@joe-job.com>
To: Mark Knecht <markknecht@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <5bdc1c8b0510061006p5339d5f3ke0079c172e15b04f@mail.gmail.com>
References: <5bdc1c8b0510051615hfd77ba8pab7ee07bde13ffd4@mail.gmail.com>
	 <20051006083043.GB21800@elte.hu>
	 <5bdc1c8b0510060900m721296h53ac1d0f0fc12351@mail.gmail.com>
	 <1128615988.14584.38.camel@mindpipe>
	 <5bdc1c8b0510060930y5648eacdm376178069dcd3958@mail.gmail.com>
	 <5bdc1c8b0510061006p5339d5f3ke0079c172e15b04f@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 06 Oct 2005 13:38:05 -0400
Message-Id: <1128620286.14584.43.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-06 at 10:06 -0700, Mark Knecht wrote:
> Is it that rt priorities are not set up correctly? Or is it something else?

Yes.  JACK is running at a lower priority on your system than all the
IRQ threads.  So disk activity is likely to cause xruns.  In qjackctl's
Setup screen set "Priority" to 80.

Lee

