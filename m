Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266807AbUHMS5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266807AbUHMS5E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 14:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266820AbUHMS5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 14:57:03 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:25011 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266807AbUHMS4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 14:56:54 -0400
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <20040813102252.GG8135@elte.hu>
References: <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu>
	 <20040810132654.GA28915@elte.hu> <20040812235116.GA27838@elte.hu>
	 <1092373132.3450.9.camel@mindpipe>  <20040813102252.GG8135@elte.hu>
Content-Type: text/plain
Message-Id: <1092423450.3450.43.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 13 Aug 2004 14:57:30 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-13 at 06:22, Ingo Molnar wrote:
> * Lee Revell <rlrevell@joe-job.com> wrote:
> 
> > Interesting results.  One of the problems is kallsyms_lookup,
> > triggered by the printks:
> 
> yeah - kallsyms_lookup does a linear search over thousands of symbols. 
> Especially since /proc/latency_trace uses it too it would be worthwile
> to implement some sort of binary searching.
> 

Would it be easier to have a mode where the symbols are not resolved,
and would just require the traces to be postprocessed? 

Lee

