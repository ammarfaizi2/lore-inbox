Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbVGKPZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbVGKPZq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 11:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbVGKPXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 11:23:51 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:58829 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261975AbVGKPVq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:21:46 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Lee Revell <rlrevell@joe-job.com>,
       Andrew Morton <akpm@osdl.org>, azarah@nosferatu.za.org, cw@f00f.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, christoph@lameter.org
In-Reply-To: <1121090939.3177.30.camel@laptopd505.fenrus.org>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	 <20050708214908.GA31225@taniwha.stupidest.org>
	 <20050708145953.0b2d8030.akpm@osdl.org>
	 <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe>
	 <1120933916.3176.57.camel@laptopd505.fenrus.org>
	 <1120934163.6488.72.camel@mindpipe> <20050709121212.7539a048.akpm@osdl.org>
	 <1120936561.6488.84.camel@mindpipe>
	 <1121088186.7407.61.camel@localhost.localdomain>
	 <20050711140510.GB14529@thunk.org>
	 <1121090939.3177.30.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1121095081.7433.72.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 11 Jul 2005 16:18:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 3) is tricky I guess, it's designed for cases that are like "I want a
> timer 1 second from now, but it's ok to be also at 1.5 seconds if that
> suits you better". Those cases are far less rare than you might think at
> first, most watchdog kind things are of this type. This accuracy thing
> will allow the kernel to save many wakeups by grouping them I suspect.
> 
> Alan: you worked on this before, where did you end up with ?

For #1/#2 add_timer_relative is an easy wrapper around add_timer for the
moment and I did play with that a bit. Never looked at the accuracy
stuff. In theory its a case of picking existing timeout points for low
resolution timers or tacking them onto an existing timeout that is near
enough. On the pratical side there area few problems with timer
performanc eon insert to consider

