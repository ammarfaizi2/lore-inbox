Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261376AbTIOTFr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 15:05:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbTIOTFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 15:05:47 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:20100 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261376AbTIOTFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 15:05:46 -0400
Date: Mon, 15 Sep 2003 20:19:25 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200309151919.h8FJJPdZ002538@81-2-122-30.bradfords.org.uk>
To: alan@lxorguk.ukuu.org.uk, davidsen@tmr.com
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Cc: john@grabjohn.com, linux-kernel@vger.kernel.org, piggin@cyberone.com.au,
       zwane@linuxpower.ca
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > In the model I'm proposing, the 386 kernel would be missing the Athlon
> > > workarounds.
> > 
> > This is unworkable unless you also have all the existing models where
> > you have fixes for later processors too. 
>
> I think John wants to have the default be that only code for the target
> CPU be included in the kernel when built for a given CPU.

Yes, that's what I meant.

> There's no
> reason why someone building for 386 would want code for other CPUs at all,
> vendors and people who want to run a single suboptimal kernel on multiple
> machines.
>
> My own suggestion is that the default could continue to be "include
> anything which doesn't break or drastically slow the target CPU," and then
> have a flag value to exclude fixups or enhancements for other CPUs. This
> allows existing code to be gradully marked for simplification by embedded
> users or those who just want to avoid overhead in their kernel.

Ah, OK, on reflection that's probably more realistic from a practical
viewpoint, (see my other post in this thread).

John.
