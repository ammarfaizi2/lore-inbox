Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262310AbVAUHtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbVAUHtO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 02:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262311AbVAUHtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 02:49:14 -0500
Received: from mx2.elte.hu ([157.181.151.9]:58512 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262310AbVAUHtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 02:49:09 -0500
Date: Fri, 21 Jan 2005 08:48:24 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Con Kolivas <kernel@kolivas.org>
Cc: ross@jose.lug.udel.edu, Paul Davis <paul@linuxaudiosystems.com>,
       "Jack O'Quin" <joq@io.com>, linux <linux-kernel@vger.kernel.org>,
       rlrevell@joe-job.com, CK Kernel <ck@vds.kolivas.org>,
       utz <utz@s2y4n2c.de>, Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
Message-ID: <20050121074824.GA22626@elte.hu>
References: <87pt00b01i.fsf@sulphur.joq.us> <200501201542.j0KFgOwo019109@localhost.localdomain> <20050120174939.GA15920@jose.lug.udel.edu> <41F03C03.3090209@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F03C03.3090209@kolivas.org>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Con Kolivas <kernel@kolivas.org> wrote:

> In terms of recommendation, the latency of non-preemptible codepaths
> will be fastest in ext3 in 2.6 due to the nature of it constantly
> being examined, addressed and updated. That does not mean it has the
> fastest performance by any stretch of the imagination. [...]

i agree with the latency observation. But ext3 got two significant
performance boosts recently, at two ends of the performance spectrum:

- in the (lots-of-)small-files area: the addition of the htree feature

- in the large-files-throughput case: with the addition of the
  reservation feature.

ext3 installed by a recent distro should have both features enabled. (i
know for sure that Fedora Core 3 with the update/erratum kernel
installed will create ext3 filesystems that utilize both of these
features by default.) 

I encourage everyone to try the famous 'create and read 1 million small
files' test on both recent ext3 and on other filesystems.

	Ingo
