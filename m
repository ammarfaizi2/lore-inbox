Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbTHYRMS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 13:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbTHYRMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 13:12:18 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:18949 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261977AbTHYRMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 13:12:12 -0400
Subject: Re: [RFC] renicing X
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3F4A3293.8070004@cyberone.com.au>
References: <3F4A3293.8070004@cyberone.com.au>
Content-Type: text/plain
Message-Id: <1061831528.2967.7.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 25 Aug 2003 19:12:08 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-08-25 at 18:00, Nick Piggin wrote:
> My scheduler patch really benefits a lot from renicing X. I
> think its because it nices more nicely. Any reasons why this
> might be a bad idea?

Well, not for me... Although renicing X with Con patches makes X feel
horrible, with your patches is not as horrible. However, I feel X much
smoother with X reniced at +0. Renicing X at -20, for example, may
reduce mouse cursor jumpiness under load, but makes X feel a little
jerky in general (window movement is not as smooth as with X niced at
+0). This is, however, based on subjective testing, not actual numbers.
But for interactivity, most of the time it's the subjective feeling of
the user about the system what matters, not numbers.

And now we're talking about sched-policy-7a: under heavy load, spawning
new processes still takes twice the time it takes when the system is
under no load. For example, spawning a new Konsole session (not a new
Konsole process, but a new session tab inside Konsole) takes approx. 1
second on my P3-700Mhz. However, with sched-policy-7a and under heavy
load (the mad while true; do a=2; done loop), it takes more than 2
seconds.

In general, sched-policy-7a feels extremely smooth and responsive in
general but, for me, Con patches offer the smoothest X experience I have
ever felt until date. Anyways, I will keep testing your patches and I
greatly encourage you to keep improving them. It's always good to have
diversity :-)

