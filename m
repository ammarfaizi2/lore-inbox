Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268828AbUHMFli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268828AbUHMFli (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 01:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268998AbUHMFkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 01:40:45 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:16536 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268828AbUHMFkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 01:40:37 -0400
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Florian Schmidt <mista.tapas@gmx.net>
In-Reply-To: <1092374851.3450.13.camel@mindpipe>
References: <20040726082330.GA22764@elte.hu>
	 <1090830574.6936.96.camel@mindpipe> <20040726083537.GA24948@elte.hu>
	 <1090832436.6936.105.camel@mindpipe> <20040726124059.GA14005@elte.hu>
	 <20040726204720.GA26561@elte.hu> <20040729222657.GA10449@elte.hu>
	 <20040801193043.GA20277@elte.hu> <20040809104649.GA13299@elte.hu>
	 <20040810132654.GA28915@elte.hu>  <20040812235116.GA27838@elte.hu>
	 <1092374851.3450.13.camel@mindpipe>
Content-Type: text/plain
Message-Id: <1092375673.3450.15.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 13 Aug 2004 01:41:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-08-13 at 01:27, Lee Revell wrote:
> On Thu, 2004-08-12 at 19:51, Ingo Molnar wrote:
> > i've uploaded the latest version of the voluntary-preempt patch:
> >      
> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.8-rc4-O6
> 

Ugh, this is a bad one:

preemption latency trace v1.0
-----------------------------
 latency: 506 us, entries: 157 (157)
 process: evolution/3461, uid: 1000
 nice: 0, policy: 0, rt_priority: 0
=======>
 0.000ms (+0.000ms): get_random_bytes (__check_and_rekey)
 0.000ms (+0.000ms): extract_entropy (get_random_bytes)
 0.002ms (+0.001ms): extract_entropy (extract_entropy)
 0.003ms (+0.001ms): SHATransform (extract_entropy)
 0.004ms (+0.000ms): memcpy (SHATransform)
 0.014ms (+0.010ms): add_entropy_words (extract_entropy)
 0.016ms (+0.002ms): SHATransform (extract_entropy)
 0.016ms (+0.000ms): memcpy (SHATransform)
 0.025ms (+0.008ms): add_entropy_words (extract_entropy)
 0.026ms (+0.000ms): SHATransform (extract_entropy)
 0.026ms (+0.000ms): memcpy (SHATransform)
 0.035ms (+0.008ms): add_entropy_words (extract_entropy)
 0.035ms (+0.000ms): SHATransform (extract_entropy)
 0.036ms (+0.000ms): memcpy (SHATransform)
 0.044ms (+0.008ms): add_entropy_words (extract_entropy)
 0.045ms (+0.000ms): SHATransform (extract_entropy)
 0.045ms (+0.000ms): memcpy (SHATransform)
 0.053ms (+0.008ms): add_entropy_words (extract_entropy)
 0.054ms (+0.000ms): SHATransform (extract_entropy)
 0.055ms (+0.000ms): memcpy (SHATransform)
 0.063ms (+0.008ms): add_entropy_words (extract_entropy)
 0.064ms (+0.000ms): SHATransform (extract_entropy)
 0.064ms (+0.000ms): memcpy (SHATransform)
 0.072ms (+0.008ms): add_entropy_words (extract_entropy)
 0.073ms (+0.000ms): SHATransform (extract_entropy)
 0.073ms (+0.000ms): memcpy (SHATransform)
 0.082ms (+0.008ms): add_entropy_words (extract_entropy)
 0.083ms (+0.001ms): SHATransform (extract_entropy)
 0.083ms (+0.000ms): memcpy (SHATransform)
 0.091ms (+0.008ms): add_entropy_words (extract_entropy)
 0.092ms (+0.000ms): SHATransform (extract_entropy)
 0.092ms (+0.000ms): memcpy (SHATransform)
 0.101ms (+0.008ms): add_entropy_words (extract_entropy)
 0.101ms (+0.000ms): SHATransform (extract_entropy)
 0.102ms (+0.000ms): memcpy (SHATransform)
 0.110ms (+0.008ms): add_entropy_words (extract_entropy)
 0.111ms (+0.000ms): SHATransform (extract_entropy)
 0.111ms (+0.000ms): memcpy (SHATransform)
 0.119ms (+0.008ms): add_entropy_words (extract_entropy)
 0.120ms (+0.000ms): SHATransform (extract_entropy)
 0.120ms (+0.000ms): memcpy (SHATransform)
 0.129ms (+0.008ms): add_entropy_words (extract_entropy)
 0.129ms (+0.000ms): SHATransform (extract_entropy)
 0.129ms (+0.000ms): memcpy (SHATransform)
 0.138ms (+0.008ms): add_entropy_words (extract_entropy)
 0.139ms (+0.000ms): SHATransform (extract_entropy)
 0.139ms (+0.000ms): memcpy (SHATransform)
 0.147ms (+0.008ms): add_entropy_words (extract_entropy)
 0.148ms (+0.000ms): SHATransform (extract_entropy)
 0.148ms (+0.000ms): memcpy (SHATransform)
 0.157ms (+0.008ms): add_entropy_words (extract_entropy)
 0.158ms (+0.000ms): SHATransform (extract_entropy)
 0.158ms (+0.000ms): memcpy (SHATransform)
 0.166ms (+0.008ms): add_entropy_words (extract_entropy)
 0.167ms (+0.000ms): SHATransform (extract_entropy)
 0.167ms (+0.000ms): memcpy (SHATransform)
 0.176ms (+0.008ms): add_entropy_words (extract_entropy)
 0.177ms (+0.000ms): SHATransform (extract_entropy)
 0.177ms (+0.000ms): memcpy (SHATransform)
 0.185ms (+0.008ms): add_entropy_words (extract_entropy)
 0.186ms (+0.000ms): SHATransform (extract_entropy)
 0.186ms (+0.000ms): memcpy (SHATransform)
 0.195ms (+0.008ms): add_entropy_words (extract_entropy)
 0.196ms (+0.000ms): SHATransform (extract_entropy)
 0.196ms (+0.000ms): memcpy (SHATransform)
 0.204ms (+0.008ms): add_entropy_words (extract_entropy)
 0.205ms (+0.000ms): SHATransform (extract_entropy)
 0.205ms (+0.000ms): memcpy (SHATransform)
 0.214ms (+0.008ms): add_entropy_words (extract_entropy)
 0.214ms (+0.000ms): SHATransform (extract_entropy)
 0.215ms (+0.000ms): memcpy (SHATransform)
 0.223ms (+0.008ms): add_entropy_words (extract_entropy)
 0.224ms (+0.000ms): SHATransform (extract_entropy)
 0.224ms (+0.000ms): memcpy (SHATransform)
 0.233ms (+0.008ms): add_entropy_words (extract_entropy)
 0.234ms (+0.001ms): SHATransform (extract_entropy)
 0.234ms (+0.000ms): memcpy (SHATransform)
 0.242ms (+0.008ms): add_entropy_words (extract_entropy)
 0.243ms (+0.000ms): SHATransform (extract_entropy)
 0.243ms (+0.000ms): memcpy (SHATransform)
 0.252ms (+0.008ms): add_entropy_words (extract_entropy)
 0.252ms (+0.000ms): SHATransform (extract_entropy)
 0.253ms (+0.000ms): memcpy (SHATransform)
 0.261ms (+0.008ms): add_entropy_words (extract_entropy)
 0.262ms (+0.000ms): SHATransform (extract_entropy)
 0.262ms (+0.000ms): memcpy (SHATransform)
 0.271ms (+0.008ms): add_entropy_words (extract_entropy)
 0.271ms (+0.000ms): SHATransform (extract_entropy)
 0.272ms (+0.000ms): memcpy (SHATransform)
 0.280ms (+0.008ms): add_entropy_words (extract_entropy)
 0.281ms (+0.000ms): SHATransform (extract_entropy)
 0.281ms (+0.000ms): memcpy (SHATransform)
 0.289ms (+0.008ms): add_entropy_words (extract_entropy)
 0.290ms (+0.000ms): SHATransform (extract_entropy)
 0.290ms (+0.000ms): memcpy (SHATransform)
 0.299ms (+0.008ms): add_entropy_words (extract_entropy)
 0.300ms (+0.000ms): SHATransform (extract_entropy)
 0.300ms (+0.000ms): memcpy (SHATransform)
 0.308ms (+0.008ms): add_entropy_words (extract_entropy)
 0.309ms (+0.000ms): SHATransform (extract_entropy)
 0.309ms (+0.000ms): memcpy (SHATransform)
 0.318ms (+0.008ms): add_entropy_words (extract_entropy)
 0.319ms (+0.000ms): SHATransform (extract_entropy)
 0.319ms (+0.000ms): memcpy (SHATransform)
 0.327ms (+0.008ms): add_entropy_words (extract_entropy)
 0.328ms (+0.000ms): SHATransform (extract_entropy)
 0.328ms (+0.000ms): memcpy (SHATransform)
 0.337ms (+0.008ms): add_entropy_words (extract_entropy)
 0.338ms (+0.000ms): SHATransform (extract_entropy)
 0.338ms (+0.000ms): memcpy (SHATransform)
 0.346ms (+0.008ms): add_entropy_words (extract_entropy)
 0.347ms (+0.000ms): SHATransform (extract_entropy)
 0.347ms (+0.000ms): memcpy (SHATransform)
 0.356ms (+0.008ms): add_entropy_words (extract_entropy)
 0.356ms (+0.000ms): SHATransform (extract_entropy)
 0.357ms (+0.000ms): memcpy (SHATransform)
 0.365ms (+0.008ms): add_entropy_words (extract_entropy)
 0.366ms (+0.000ms): SHATransform (extract_entropy)
 0.366ms (+0.000ms): memcpy (SHATransform)
 0.375ms (+0.008ms): add_entropy_words (extract_entropy)
 0.375ms (+0.000ms): SHATransform (extract_entropy)
 0.376ms (+0.000ms): memcpy (SHATransform)
 0.384ms (+0.008ms): add_entropy_words (extract_entropy)
 0.385ms (+0.001ms): add_entropy_words (extract_entropy)
 0.396ms (+0.010ms): credit_entropy_store (extract_entropy)
 0.397ms (+0.001ms): SHATransform (extract_entropy)
 0.397ms (+0.000ms): memcpy (SHATransform)
 0.405ms (+0.008ms): add_entropy_words (extract_entropy)
 0.406ms (+0.000ms): SHATransform (extract_entropy)
 0.407ms (+0.000ms): memcpy (SHATransform)
 0.415ms (+0.008ms): add_entropy_words (extract_entropy)
 0.416ms (+0.001ms): SHATransform (extract_entropy)
 0.416ms (+0.000ms): memcpy (SHATransform)
 0.425ms (+0.008ms): add_entropy_words (extract_entropy)
 0.425ms (+0.000ms): SHATransform (extract_entropy)
 0.426ms (+0.000ms): memcpy (SHATransform)
 0.434ms (+0.008ms): add_entropy_words (extract_entropy)
 0.435ms (+0.001ms): SHATransform (extract_entropy)
 0.436ms (+0.000ms): memcpy (SHATransform)
 0.444ms (+0.008ms): add_entropy_words (extract_entropy)
 0.445ms (+0.000ms): SHATransform (extract_entropy)
 0.445ms (+0.000ms): memcpy (SHATransform)
 0.453ms (+0.008ms): add_entropy_words (extract_entropy)
 0.455ms (+0.001ms): SHATransform (extract_entropy)
 0.455ms (+0.000ms): memcpy (SHATransform)
 0.463ms (+0.008ms): add_entropy_words (extract_entropy)
 0.464ms (+0.000ms): SHATransform (extract_entropy)
 0.464ms (+0.000ms): memcpy (SHATransform)
 0.473ms (+0.008ms): add_entropy_words (extract_entropy)
 0.474ms (+0.001ms): SHATransform (extract_entropy)
 0.474ms (+0.000ms): memcpy (SHATransform)
 0.482ms (+0.008ms): add_entropy_words (extract_entropy)
 0.483ms (+0.000ms): SHATransform (extract_entropy)
 0.483ms (+0.000ms): memcpy (SHATransform)
 0.492ms (+0.008ms): add_entropy_words (extract_entropy)
 0.493ms (+0.001ms): local_bh_enable (__check_and_rekey)
 0.494ms (+0.000ms): check_preempt_timing (sub_preempt_count)

Lee

