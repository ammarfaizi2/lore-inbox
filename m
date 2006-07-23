Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWGWU01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWGWU01 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 16:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWGWU00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 16:26:26 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:17824 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751298AbWGWU00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 16:26:26 -0400
Message-ID: <44C3DB6C.6010800@garzik.org>
Date: Sun, 23 Jul 2006 16:26:20 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: ricknu-0@student.ltu.se
CC: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Michael Buesch <mb@bu3sch.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, larsbj@gullik.net
Subject: Re: [RFC][PATCH] A generic boolean (version 4)
References: <1153341500.44be983ca1407@portal.student.luth.se> <1153669750.44c39a7607a30@portal.student.luth.se> <Pine.LNX.4.61.0607231805210.26413@yvahk01.tjqt.qr> <1153683377.44c3cfb146443@portal.student.luth.se>
In-Reply-To: <1153683377.44c3cfb146443@portal.student.luth.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ricknu-0@student.ltu.se wrote:
>>> +#undef false
>>> +#undef true
>>> +
>>> +enum {
>>> +	false	= 0,
>>> +	true	= 1
>>> +};
>>> +
>>> +#define false false
>>> +#define true true 
>> Can someone please tell me what advantage 'define true true' is going to
>> bring, besides than being able to '#ifdef true'?
> 
> Assembly-code can not use enum but #define. That is the reason I find but there
> might be more.


That won't work -- the #define just makes the enum available, which 
doesn't work at the assembler level.

But assembly code doesn't use this stuff, so no worries.

	Jeff


