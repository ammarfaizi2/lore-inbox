Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbUC2MbT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 07:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262910AbUC2MaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 07:30:17 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:25281 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262894AbUC2MVr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:21:47 -0500
Date: Mon, 29 Mar 2004 17:50:45 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Arjan van de Ven <arjanv@redhat.com>, Robert Love <rml@ximian.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU for low latency (experimental)
Message-ID: <20040329122045.GB3683@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040324175142.GW2065@dualathlon.random> <20040324213914.GD4539@in.ibm.com> <20040324225326.GH2065@dualathlon.random> <20040324231145.GB12035@in.ibm.com> <20040324233430.GJ2065@dualathlon.random> <20040324234643.GD12035@in.ibm.com> <s5hwu549alg.wl@alsa2.suse.de> <20040328172036.GH5648@in.ibm.com> <s5hu10898za.wl@alsa2.suse.de> <s5hvfkovsqo.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hvfkovsqo.wl@alsa2.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 12:43:11PM +0200, Takashi Iwai wrote:
> At Sun, 28 Mar 2004 19:28:41 +0200,
> I wrote:
> > 
> > > > anyway, i confirmed that with the original krcud patch the latency
> > > > with dcache flood can be eliminated.
> > > 
> > > Does the throttle-rcu patch also help eliminate dcache flood ? You
> > > can try by just changing count >= rcumaxbatch to ++count > rcumaxbatch.
> > 
> > i'll try it later.
> 
> the throttle-rcu patch does work indeed well even without preemption.
> i've tested maxbatch=16 and plugticks=0.  in the older version, there
> was 20ms long latency, while in the patched version, no measurable
> latency more than 1ms.

Thanks for the measurements. throttle-rcu may eventually be the way
to go, but I would wait until we have sorted out several other problems
like route cache DoS testing that we are looking at currently.

Thanks
Dipankar
