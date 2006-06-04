Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932189AbWFDKmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWFDKmE (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 06:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWFDKmD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 06:42:03 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:39597 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932189AbWFDKmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 06:42:01 -0400
Date: Sun, 4 Jun 2006 12:41:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm3
Message-ID: <20060604104121.GA16117@elte.hu>
References: <20060603232004.68c4e1e3.akpm@osdl.org> <986ed62e0606040238t712d7b01xde5f4a23da12fb1a@mail.gmail.com> <20060604024937.0fb57258.akpm@osdl.org> <6bffcb0e0606040308j28d9e89axa0136908c5530ae3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6bffcb0e0606040308j28d9e89axa0136908c5530ae3@mail.gmail.com>
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

> BTW. I still get this bug
> http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm2/bug_1.jpg
> http://www.stardust.webpages.pl/files/mm/2.6.17-rc5-mm2/mm-config

could you please apply the following patches ontop of -mm3:

  http://redhat.com/~mingo/lockdep-patches/lockdep-combo-2.6.17-rc5-mm3.patch
  http://redhat.com/~mingo/lockdep-patches/lockdep-tracer-2.6.17-rc5-mm3.patch

accept all the default 'make oldconfig' options and reboot into the 
patched kernel. If everything goes well then the system should still 
boot up fine and you should still get the lockdep warning - but this 
time there should be a long trace in /proc/latency_trace. Please upload 
that trace - it gives us the kernel's function trace, leading up to the 
warning.

	Ingo
