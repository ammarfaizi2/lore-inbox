Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263545AbTJQPir (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 11:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263546AbTJQPiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 11:38:46 -0400
Received: from pentafluge.infradead.org ([213.86.99.235]:4513 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263545AbTJQPiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 11:38:06 -0400
Subject: Re: killing a kernel thread.
From: David Woodhouse <dwmw2@infradead.org>
To: root@chaos.analogic.com
Cc: Suresh Subramanian <Suresh.Subramanian@lntinfotech.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0310170950290.3209@chaos>
References: <OFE97AECC7.A7E1AF0C-ON65256DC2.0046781F@lntinfotech.com>
	 <Pine.LNX.4.53.0310170950290.3209@chaos>
Content-Type: text/plain
Message-Id: <1066405067.6744.1444.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-2.dwmw2.3) 
Date: Fri, 17 Oct 2003 16:37:49 +0100
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: dwmw2@infradead.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ooh ooh RBJcode. I'm going to be fair and only pick one of the errors,
leaving many more for others to play the game too...



On Fri, 2003-10-17 at 09:51 -0400, Richard B. Johnson wrote:

>   __u32 volatile status;

>   while (!test_bit(0,&priv->status)) {

test_bit() and friends work on 'unsigned long' not uint32_t.

-- 
dwmw2

