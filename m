Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264409AbTLVMu4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 07:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264410AbTLVMu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 07:50:56 -0500
Received: from mx2.elte.hu ([157.181.151.9]:48853 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264409AbTLVMuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 07:50:55 -0500
Date: Mon, 22 Dec 2003 13:51:30 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew McGregor <andrew@indranet.co.nz>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 vs 2.4 regression when running gnomemeeting
Message-ID: <20031222125130.GA13685@elte.hu>
References: <1071864709.1044.172.camel@localhost> <1071885178.1044.227.camel@localhost> <3FE3B61C.4070204@cyberone.com.au> <200312201355.08116.kernel@kolivas.org> <1071891168.1044.256.camel@localhost> <14897962.1072137278@[192.168.1.249]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14897962.1072137278@[192.168.1.249]>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: SpamAssassin ELTE 1.0
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew McGregor <andrew@indranet.co.nz> wrote:

> Hmm.  Gnomemeeting has a history of strange threading issues
> (actually, all OpenH323 derived projects do).  Is there a threading
> change that might explain this?

we tracked down the bug to pwlib's sched_yield() usage. Other code that
uses sched_yield() to 'sleep a bit' could be affected as well.

	Ingo
