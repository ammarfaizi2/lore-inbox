Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267361AbUJIU1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267361AbUJIU1w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 16:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267380AbUJIU0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 16:26:53 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:23962 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267361AbUJIUZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 16:25:13 -0400
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
From: Lee Revell <rlrevell@joe-job.com>
To: Robert Love <rml@novell.com>
Cc: stefan.eletzhofer@eletztrick.de,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1097353225.9973.7.camel@lucy>
References: <41677E4D.1030403@mvista.com> <416822B7.5050206@opersys.com>
	 <1097346628.1428.11.camel@krustophenia.net>
	 <20041009212614.GA25441@tier.local>
	 <1097350227.1428.41.camel@krustophenia.net>
	 <20041009213817.GB25441@tier.local>
	 <1097351221.1428.46.camel@krustophenia.net>  <1097353225.9973.7.camel@lucy>
Content-Type: text/plain
Message-Id: <1097353512.1428.64.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 09 Oct 2004 16:25:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-09 at 16:20, Robert Love wrote:
> On Sat, 2004-10-09 at 15:47 -0400, Lee Revell wrote:
> 
> > Yes.  The upper bound on the response time of an RT task is a function
> > of the longest non-preemptible code path in the kernel.  Currently this
> > is the processing of a single packet by netif_receive_skb.
> > 
> > AIUI hard realtime is about bounded response times.  How does this not
> > qualify?
> 
> I am actually in agreement with you, favoring this soft real-time
> approach, but this is not bounded response time or determinism.  There
> are no guarantees, no measurements conducted with all possible inputs,
> sizes, errors, and so on.  This soft real-time approach gives great
> average case--but the worst case is only a measurement on a specific
> machine in a specific workload.

I did not mean to say that VP approach alone can do hard realtime, that
was just an example.  But, when combined the MontaVista approach of
turning all but ~20 spinlocks into mutexes, it seems like the amount of
non-preemptible code is small enough that you could analyze it all and
start to make hard RT guarantees.

Lee

