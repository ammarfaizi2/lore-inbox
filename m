Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbUCYTio (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 14:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263583AbUCYTio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 14:38:44 -0500
Received: from mx1.elte.hu ([157.181.1.137]:37574 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263568AbUCYTim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 14:38:42 -0500
Date: Thu, 25 Mar 2004 20:39:13 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: jun.nakajima@intel.com, ricklind@us.ibm.com, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org, akpm@osdl.org, kernel@kolivas.org,
       rusty@rustcorp.com.au, anton@samba.org, lse-tech@lists.sourceforge.net,
       mbligh@aracnet.com
Subject: Re: [Lse-tech] [patch] sched-domain cleanups, sched-2.6.5-rc2-mm2-A3
Message-ID: <20040325193913.GA14024@elte.hu>
References: <7F740D512C7C1046AB53446D372001730111990F@scsmsx402.sc.intel.com> <20040325154011.GB30175@wotan.suse.de> <20040325190944.GB12383@elte.hu> <20040325162121.5942df4f.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040325162121.5942df4f.ak@suse.de>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andi Kleen <ak@suse.de> wrote:

> That won't help for threaded programs that use clone(). OpenMP is such
> a case.

yeah, agreed. Also, exec-balance, if applied to fork(), would migrate
the parent which is not what we want. We could perhaps migrate the
parent to the target CPU, copy the context, then migrate the parent back
to the original CPU ... but this sounds too complex.

	Ingo
