Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161042AbVKQAdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbVKQAdx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 19:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161043AbVKQAdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 19:33:53 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:50316 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1161042AbVKQAdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 19:33:52 -0500
Subject: Re: Calibration issues with USB disc present.
From: Lee Revell <rlrevell@joe-job.com>
To: Max Krasnyansky <maxk@qualcomm.com>
Cc: george@mvista.com, john stultz <johnstul@us.ibm.com>,
       Greg KH <greg@kroah.com>, ganzinger@mvista.com,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <437BC8D6.4040402@qualcomm.com>
References: <43750EFD.3040106@mvista.com>
	 <1131746228.2542.11.camel@cog.beaverton.ibm.com>
	 <20051112050502.GC27700@kroah.com> <4376130D.1080500@mvista.com>
	 <20051112213332.GA16016@kroah.com> <4378DDC5.80103@mvista.com>
	 <20051114184940.GA876@kroah.com> <1131998339.4668.16.camel@leatherman>
	 <4379070C.8090709@mvista.com>  <437BC8D6.4040402@qualcomm.com>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 19:30:23 -0500
Message-Id: <1132187423.3008.21.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 16:03 -0800, Max Krasnyansky wrote:
> I think in the short term your best bet is to globally disable SMI at
> early
> boot stage (ie before TSC calibration).
> Some people might argue that it's not the most graceful solution
> because it might
> brake some BIOS features but it's a very common trick that is used by
> RT folks
> (for example RTAI has configurable option to enable SMI workaround)
> because
> on some chipset/BIOS combinations SMIs introduce horrible latencies.
> And you
> cannot do much about that other than disabling SMI.
> I have not seen any reports of negative side effects of disabling SMI
> yet. But
> if you're worried about that you could re-enable it later when you're
> done with
> TSC calibration and stuff.
> 

Hmm, interesting, I had no idea this was possible.  Is there a generic
way to disable SMI?  It would be useful for the -rt tree as lots of low
latency audio users have problems with SMI induced underruns.

Lee

