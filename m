Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbUC2Kae (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 05:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUC2Kae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 05:30:34 -0500
Received: from ns.suse.de ([195.135.220.2]:58040 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262790AbUC2Kad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 05:30:33 -0500
Date: Mon, 29 Mar 2004 07:07:52 +0200
From: Andi Kleen <ak@suse.de>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: mingo@elte.hu, jun.nakajima@intel.com, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net,
       mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups,
 sched-2.6.5-rc2-mm2-A3
Message-Id: <20040329070752.087ad495.ak@suse.de>
In-Reply-To: <200403291021.i2TAKxx21370@owlet.beaverton.ibm.com>
References: <20040329084531.GB29458@wotan.suse.de>
	<200403291021.i2TAKxx21370@owlet.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2004 02:20:58 -0800
Rick Lindsley <ricklind@us.ibm.com> wrote:

> I've got a web page up now on my home machine which shows data from
> schedstats across the various flavors of 2.6.4 and 2.6.5-rc2 under
> load from kernbench, SPECjbb, and SPECdet.
> 
>     http://eaglet.rain.com/rick/linux/sched-domain/index.html
> 
> Two things that stand out are that sched-domains tends to call
> load_balance() less frequently when it is idle and more frequently when
> it is busy (as compared to the "standard" scheduler.)  Another is that
> even though it moves fewer tasks on average, the sched-domains code shows
> about half of pull_task()'s work is coming from active_load_balance() ...
> and that seems wrong.  Could these be contributing to what you're seeing?

Sounds quite possible yes.

-Andi
