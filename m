Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265596AbUAPSmx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 13:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265608AbUAPSmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 13:42:53 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:43682
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S265596AbUAPSmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 13:42:08 -0500
Message-ID: <40083052.80703@tmr.com>
Date: Fri, 16 Jan 2004 13:41:22 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 1/2: Make gotoxy & siblings use unsigned variables
References: <1c9S3-75-23@gated-at.bofh.it> <1cauN-131-17@gated-at.bofh.it> <1cb7n-1Z6-17@gated-at.bofh.it> <1cbAw-2BB-27@gated-at.bofh.it>
In-Reply-To: <1cbAw-2BB-27@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
>>>Shouldn't we be using "size_t" for unsigned int
> 
> 
>>You might be right. I was just being consistent with the other definitions.
> 
> 
> These are character positions on a screen.
> When did you last see a console in text mode with a line length
> of more than 2^31 ?
> 
> If you go for a minimal patch then you should replace "char"
> in one or two places by "unsigned char" and that is all.

Are these screen positions or offsets into the string for the line? The 
reason I ask is that with a 2-byte character set no char is going to do 
the latter reliably, not only do people run 132 col mode with vt100 
windows, just hitting the "full screen" button with most WM will give 
you >127 columns.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
