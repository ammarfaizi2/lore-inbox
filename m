Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbTL3XBn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 18:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265917AbTL3W7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 17:59:25 -0500
Received: from imf19aec.mail.bellsouth.net ([205.152.59.67]:18599 "EHLO
	imf19aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S265907AbTL3W6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 17:58:24 -0500
Subject: Re: no DRQ after issuing WRITE was Re: 2.4.23-uv3 patch set
	released
From: Rob Love <rml@ximian.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Daniel Tram Lux <daniel@starbattle.com>, steve@drifthost.com,
       James Bourne <jbourne@hardrock.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Gergely Tamas <dice@mfa.kfki.hu>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <Pine.LNX.4.58.0312301452370.2065@home.osdl.org>
References: <Pine.LNX.4.51.0312290052470.1599@cafe.hardrock.org>
	 <Pine.LNX.4.58L.0312300935040.22101@logos.cnet>
	 <Pine.LNX.4.58.0312301130430.2065@home.osdl.org>
	 <Pine.LNX.4.58L.0312301849400.23875@logos.cnet>
	 <Pine.LNX.4.58.0312301352570.2065@home.osdl.org>
	 <1072823015.4350.40.camel@fur>
	 <Pine.LNX.4.58.0312301452370.2065@home.osdl.org>
Content-Type: text/plain
Message-Id: <1072825101.4350.55.camel@fur>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Tue, 30 Dec 2003 17:58:22 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-30 at 17:54, Linus Torvalds wrote:

> Interrupts are _not_ disabled here, very much on purpose. If they were, 
> then "jiffies" wouldn't update, and the timeouts wouldn't work.
> 
> This is what that _stupid_ "local_irq_set()" function does: it saves the 
> old irq masking state, and then it enables it.
> 
> The whole concept doesn't make any sense. If you enable interrupts, there 
> is little point in saving the callers irq mask, since it already got 
> deflated.

Ah, OK.  local_irq_set() is worthless, then.

Curious to see the results of upping the timeout.

	Rob Love


