Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262520AbUC2KWD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 05:22:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbUC2KWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 05:22:03 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:20155 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262520AbUC2KWB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 05:22:01 -0500
Message-Id: <200403291021.i2TAKxx21370@owlet.beaverton.ibm.com>
To: Andi Kleen <ak@suse.de>
cc: Ingo Molnar <mingo@elte.hu>, jun.nakajima@intel.com,
       piggin@cyberone.com.au, linux-kernel@vger.kernel.org, akpm@osdl.org,
       kernel@kolivas.org, rusty@rustcorp.com.au, anton@samba.org,
       lse-tech@lists.sourceforge.net, mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3 
In-reply-to: Your message of "Mon, 29 Mar 2004 10:45:31 +0200."
             <20040329084531.GB29458@wotan.suse.de> 
Date: Mon, 29 Mar 2004 02:20:58 -0800
From: Rick Lindsley <ricklind@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a web page up now on my home machine which shows data from
schedstats across the various flavors of 2.6.4 and 2.6.5-rc2 under
load from kernbench, SPECjbb, and SPECdet.

    http://eaglet.rain.com/rick/linux/sched-domain/index.html

Two things that stand out are that sched-domains tends to call
load_balance() less frequently when it is idle and more frequently when
it is busy (as compared to the "standard" scheduler.)  Another is that
even though it moves fewer tasks on average, the sched-domains code shows
about half of pull_task()'s work is coming from active_load_balance() ...
and that seems wrong.  Could these be contributing to what you're seeing?

Rick
