Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWGWVos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWGWVos (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 17:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWGWVos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 17:44:48 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:2722 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1750736AbWGWVos (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 17:44:48 -0400
Message-ID: <44C3EDC6.5090404@garzik.org>
Date: Sun, 23 Jul 2006 17:44:38 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: ricknu-0@student.ltu.se, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Michael Buesch <mb@bu3sch.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, larsbj@gullik.net
Subject: Re: [RFC][PATCH] A generic boolean (version 4)
References: <1153341500.44be983ca1407@portal.student.luth.se> <1153669750.44c39a7607a30@portal.student.luth.se> <Pine.LNX.4.61.0607231805210.26413@yvahk01.tjqt.qr> <44C3DB28.2090003@garzik.org> <Pine.LNX.4.61.0607232316420.1638@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0607232316420.1638@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>>> +#define false false
>>>> +#define true true 
>>> Can someone please tell me what advantage 'define true true' is going to
>>> bring, besides than being able to '#ifdef true'?
>> It
>>
>> (a) makes type information available to the C compiler, where a plain #define
>> does not.
> 
> Do you mean preprocessor? C already knows about true from the enum.

I was describing the overall purpose of the enum + #define change, when 
you take my "(a)" and "(b)" in sum.


>> (b) handles all '#ifndef true' statements properly
> 
> Holy *, is there _really_ code in linux/ that depends on true being 
> [not] defined?

I suggest re-reading the boolean patches in this thread, to answer that 
question...

Programmer wanting to use boolean inevitably add an '#ifndef true' or 
'#ifndef TRUE' style statement to their code.

	Jeff



