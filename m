Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbVLZKnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbVLZKnI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 05:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbVLZKnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 05:43:07 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:8618 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751069AbVLZKnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 05:43:05 -0500
Subject: Re: [patch 0/9] mutex subsystem, -V4
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, zippel@linux-m68k.org, hch@infradead.org,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, arjanv@infradead.org, nico@cam.org,
       jes@trained-monkey.org, zwane@arm.linux.org.uk, oleg@tv-sign.ru,
       dhowells@redhat.com, bcrl@kvack.org, rostedt@goodmis.org, ak@suse.de,
       rmk+lkml@arm.linux.org.uk
In-Reply-To: <20051226023549.f46add77.akpm@osdl.org>
References: <20051222114147.GA18878@elte.hu>
	 <20051222153014.22f07e60.akpm@osdl.org>
	 <20051222233416.GA14182@infradead.org>
	 <200512251708.16483.zippel@linux-m68k.org>
	 <20051225150445.0eae9dd7.akpm@osdl.org> <20051225232222.GA11828@elte.hu>
	 <20051226023549.f46add77.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 26 Dec 2005 11:42:55 +0100
Message-Id: <1135593776.2935.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> hm.  16 CPUs hitting the same semaphore at great arrival rates.  The cost
> of a short spin is much less than the cost of a sleep/wakeup.  The machine
> was doing 100,000 - 200,000 context switches per second.

interesting.. this might be a good indication that a "spin a bit first"
mutex slowpath for some locks might be worth implementing...


