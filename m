Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWGWUZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWGWUZU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 16:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWGWUZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 16:25:20 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:7840 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751292AbWGWUZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 16:25:19 -0400
Message-ID: <44C3DB28.2090003@garzik.org>
Date: Sun, 23 Jul 2006 16:25:12 -0400
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
References: <1153341500.44be983ca1407@portal.student.luth.se> <1153669750.44c39a7607a30@portal.student.luth.se> <Pine.LNX.4.61.0607231805210.26413@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0607231805210.26413@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>> +#undef false
>> +#undef true
>> +
>> +enum {
>> +	false	= 0,
>> +	true	= 1
>> +};
>> +
>> +#define false false
>> +#define true true 
> 
> Can someone please tell me what advantage 'define true true' is going to
> bring, besides than being able to '#ifdef true'?

It

(a) makes type information available to the C compiler, where a plain 
#define does not.
(b) handles all '#ifndef true' statements properly

	Jeff


