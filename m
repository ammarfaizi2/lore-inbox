Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266786AbUGLKpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266786AbUGLKpQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 06:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266791AbUGLKpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 06:45:16 -0400
Received: from holomorphy.com ([207.189.100.168]:37261 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266789AbUGLKox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 06:44:53 -0400
Date: Mon, 12 Jul 2004 03:44:42 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rajput <rajput@indo.net>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Instrumenting high latency
Message-ID: <20040712104442.GZ21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rajput <rajput@indo.net>, Con Kolivas <kernel@kolivas.org>,
	linux-kernel@vger.kernel.org
References: <cone.1089613755.742689.28499.502@pc.kolivas.org> <005a01c467fc$cd8dac50$1002a8c0@3dijsrwin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <005a01c467fc$cd8dac50$1002a8c0@3dijsrwin>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 04:11:32PM +0530, Rajput wrote:
> what is the difference in interrupt latency with and without your patch.
> Regards,
> Rajput.

This is meant to instrument scheduling latency, it doesn't improve
anything directly. It likely introduces a fair amount of overhead.
In the event a poor preempt_thresh= parameter is chosen, it may render
systems effectively unusable due to endless printk()'ing (which I should
fix via printk_ratelimit() shortly).

I recommend applying and/or enabling this only for diagnostic purposes.


-- wli
