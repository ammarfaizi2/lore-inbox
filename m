Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbTIEJQL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 05:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbTIEJQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 05:16:11 -0400
Received: from hera.cwi.nl ([192.16.191.8]:10680 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262122AbTIEJQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 05:16:09 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 5 Sep 2003 11:16:05 +0200 (MEST)
Message-Id: <UTC200309050916.h859G5813732.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, mpm@selenic.com
Subject: Re: [PATCH] add_mouse_randomness
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From oxymoron@waste.org  Fri Sep  5 07:01:30 2003
    From: Matt Mackall <mpm@selenic.com>

    > Today:
    > Every keypress and every key release causes two calls of
    > add_mouse_randomness and one call of add_keyboard_randomness.
    > Key repeat causes lots of calls of add_mouse_randomness.
    > 
    > The random driver contains a mechanism (delta, delta2, delta3)
    > for estimating the amount of entropy in a stream of moments in
    > time. But the fact that every event causes two calls, very
    > quickly after each other, poisons this mechanism, and makes us
    > overestimate.

    The real problem is that the deltas are calculated from gigahertz
    cycle counters, but yes, we're calling too frequently and blowing away
    useful history. I've experimented with making the deltas per-source as
    well.

I wouldnt know what is wrong with using gigahertz cycle counters.
The deltas are already per-source.
