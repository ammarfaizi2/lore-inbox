Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751040AbWFEMZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751040AbWFEMZV (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 08:25:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbWFEMZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 08:25:21 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:49633 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751039AbWFEMZU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 08:25:20 -0400
Date: Mon, 5 Jun 2006 14:24:45 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch, -rc5-mm3] fix IDE deadlock in error reporting code
Message-ID: <20060605122445.GA4769@elte.hu>
References: <986ed62e0606040238t712d7b01xde5f4a23da12fb1a@mail.gmail.com> <20060604024937.0fb57258.akpm@osdl.org> <6bffcb0e0606040308j28d9e89axa0136908c5530ae3@mail.gmail.com> <20060604104121.GA16117@elte.hu> <6bffcb0e0606040407u4f56f7fdyf5ec479314afc082@mail.gmail.com> <20060604213803.GC5898@elte.hu> <6bffcb0e0606041535u10fdb7c2o9ac38d6fb80fd28d@mail.gmail.com> <20060605083016.GA31013@elte.hu> <20060605083530.GA31738@elte.hu> <6bffcb0e0606050433i1261d3e4sd0d958fb15208596@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0606050433i1261d3e4sd0d958fb15208596@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -3.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-3.1 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.2 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:

> Hi,
> 
> On 05/06/06, Ingo Molnar <mingo@elte.hu> wrote:
> >
> >* Ingo Molnar <mingo@elte.hu> wrote:
> >
> >> ah. That's a real deadlock scenario. Does the patch below fix it? If
> >> yes then i think this is a candidate for 2.6.17 merging too.
> >
> >actually, the replacement patch below is better i think - it moves the
> >ide_lock taking to outside the printing section. That should still be OK
> >as we dont call other functions from within the section, and it should
> >also result in slightly more robust printing, as the whole printing code
> >will be atomic under ide_lock.
> 
> Probably fixed, thanks.

could you send a confirmation if/when you have tried this? I dont get 
the same message (i have another IDE chipset).

	Ingo
