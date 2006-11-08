Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423697AbWKHVH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423697AbWKHVH1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 16:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423784AbWKHVH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 16:07:27 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:15851 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1423697AbWKHVHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 16:07:25 -0500
Subject: Re: [PATCH] HZ: 300Hz support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <1163018898.3138.388.camel@laptopd505.fenrus.org>
References: <1163018557.23956.92.camel@localhost.localdomain>
	 <1163018898.3138.388.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Nov 2006 21:12:01 +0000
Message-Id: <1163020321.23956.96.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-11-08 am 21:48 +0100, ysgrifennodd Arjan van de Ven:
> > I'd argue we should remove 250 and add 300, but that might be excess
> > disruption for now.
> 
> 
> the last time 300 was proposed the counter argument was that it was
> lousy in terms of PIT rounding... did you check that out?

It keeps time better than 250 when I tried it. It is not perfect but
then the PIT runs at a stupid rate so any choice is a little bit off. I
think there might be a better argument anyway for making HZ fixed at
1000 and adding a boot time parameter/sysctl value which is a "ticks
divisor", so on a server you can do

	echo "10" >/proc/sys/tick_granularity

and jiffies bumps in 10s 1/10th as often. That needs someone who
understands the maths and the behaviour of the time slew and xntp stuff
to do the job right though, and that isn't me.

Alan

