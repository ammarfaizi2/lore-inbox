Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133084AbRDZDwi>; Wed, 25 Apr 2001 23:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133086AbRDZDw2>; Wed, 25 Apr 2001 23:52:28 -0400
Received: from www.wen-online.de ([212.223.88.39]:15884 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S133084AbRDZDwS>;
	Wed, 25 Apr 2001 23:52:18 -0400
Date: Thu, 26 Apr 2001 05:51:39 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Dan Maas <dmaas@dcine.com>
cc: Michael Rothwell <rothwell@holly-springs.nc.us>,
        <linux-kernel@vger.kernel.org>
Subject: Re: #define HZ 1024 -- negative effects?
In-Reply-To: <004f01c0cdf4$f17f4ce0$0701a8c0@morph>
Message-ID: <Pine.LNX.4.33.0104260508001.566-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2001, Dan Maas wrote:

> The only other possibility I can think of is a scheduler anomaly. A thread
> arose on this list recently about strange scheduling behavior of processes
> using local IPC - even though one process had readable data pending, the
> kernel would still go idle until the next timer interrupt. If this is the
> case, then HZ=1024 would kick the system back into action more quickly...

Hmm.  I've caught tasks looping here (experimental tree but..) with
interrupts enabled, but schedule never being called despite having
many runnable tasks.

	-Mike

