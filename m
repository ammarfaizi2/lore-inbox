Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262506AbULCUYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbULCUYH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 15:24:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbULCUXw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 15:23:52 -0500
Received: from www1.cdi.cz ([194.213.194.49]:46303 "EHLO www1.cdi.cz")
	by vger.kernel.org with ESMTP id S262506AbULCUWQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 15:22:16 -0500
Date: Fri, 3 Dec 2004 21:21:50 +0100 (CET)
From: devik <devik@cdi.cz>
X-X-Sender: <devik@devix>
To: Dimitri Sivanich <sivanich@sgi.com>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, <linux-kernel@vger.kernel.org>,
       <piggin@cyberone.com.au>
Subject: Re: [PATCH] sched isolcpus=1 related OOPS in 2.6.9
In-Reply-To: <20041203194713.GB16069@sgi.com>
Message-ID: <Pine.LNX.4.33.0412032111560.493-100000@devix>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> After a quick look, this patch looks OK (although I haven't had a chance to
> test it yet).  I don't know what what was intended with a default cpu_power
> of 0, but I don't believe that a value of SCHED_LOAD_SCALE should negatively
> affect the isolated domains (versus any other value).

Hello Dimitri,

thanks for your check. As I understand the code (it took me
5 hours eh eh) only relative sizes of cpu_power within one
domain matter. Thus in isolated domain one can use any nonzero
value. Also SCHED_LOAD_SCALE is probably ok in principle because
the value means "power of one typical CPU" AFAIK.

I'm not sure who is official maintainer of the scheduler and
whether he will see/integrate the patch ...

devik

