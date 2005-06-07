Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262031AbVFGXM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbVFGXM1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 19:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVFGXM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 19:12:27 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:2502 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262031AbVFGXMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 19:12:25 -0400
Subject: Re: [Trivial PATCH] new timeofday: move time sources into arch
	subdirectories
From: john stultz <johnstul@us.ibm.com>
To: tglx@linutronix.de
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1118181331.20785.547.camel@tglx.tec.linutronix.de>
References: <1118181331.20785.547.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Date: Tue, 07 Jun 2005 16:12:15 -0700
Message-Id: <1118185935.5191.6.camel@leatherman>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-07 at 23:55 +0200, Thomas Gleixner wrote:
> The patch moves the x86(_64) speficic timesources into
> drivers/timesource/x86.
> 
> Reason: When other architectures start to move their TOD implementations
> to the new design, the timesource directory will become an unstructured
> collection of timesources within no time. Especially the embedded SoC
> world tends to produce zillions of variants.
> 
> The base directory should only contain generic architecture independent
> timesource drivers IMHO.

Hey! Thanks for the feedback! I'm trying to encourage architectures to
share timesource drivers, so for now I'm not so worried if we end up
with something that looks like drivers/net/. 

So unless you strenuously object, I say lets put it off until the need
becomes a bit more apparent. Although its likely I'll agree with you
once I've started working on converting ARM. :)

thanks
-john


