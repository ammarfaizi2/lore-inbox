Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261844AbVGEOc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbVGEOc2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 10:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbVGEOc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 10:32:28 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:47112 "EHLO mail.dsa-ac.de")
	by vger.kernel.org with ESMTP id S261863AbVGEOQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 10:16:06 -0400
Date: Tue, 5 Jul 2005 16:16:01 +0200 (CEST)
From: gl@dsa-ac.de
To: linux-kernel@vger.kernel.org
Subject: Re: wake_up() from interrupt - on the next jiffie?
In-Reply-To: <Pine.LNX.4.56.0507041549440.1519@pcgl.dsa-ac.de>
Message-ID: <Pine.LNX.4.56.0507051613420.1519@pcgl.dsa-ac.de>
References: <Pine.LNX.4.56.0507041549440.1519@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Solved (below).

On Mon, 4 Jul 2005 gl@dsa-ac.de wrote:

> This might well be my basic misunderstanding, or the test was wrong, but
> the probability is pretty low, so, asking here.
>
> I thought, if a task sleeps on, say, read() and then data come and there's
> no other runnable task with a higher priority, the sleeping task should be
> woken up immediately. My test showed that the task is only woken up on the
> next jiffie. Kernel 2.6.11.10.
>
> Details: a program does a cfmakeraw() on a ttyS, and does blocking reads

setserial low_latency solves the problem. Thanks for not answering:-)

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
