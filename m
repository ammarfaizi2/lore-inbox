Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbTFFQd3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 12:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262011AbTFFQd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 12:33:28 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:50910 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262008AbTFFQdW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 12:33:22 -0400
Date: Fri, 6 Jun 2003 11:46:42 -0500
Subject: Re: __user annotations
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linux-kernel@vger.kernel.org
To: Linus Torvalds <torvalds@transmeta.com>
From: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <Pine.LNX.4.44.0306051505480.1754-100000@home.transmeta.com>
Message-Id: <7369DBDA-983E-11D7-8338-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, Jun 5, 2003, at 17:07 US/Central, Linus Torvalds wrote:
>
> On Thu, 5 Jun 2003, Hollis Blanchard wrote:
>>
>> Two ioctl functions in sound/oss/awe_wave.c were directly 
>> dereferencing
>> a user-supplied pointer in a few places. Please apply.
>
> When you do patches like this, can you please add the "__user" 
> annotations
> while you're at it?

I was hoping for a little more explanation on that before I used it... 
for example, will the following code generate a warning? An error?

void func_b(void *b) { }

void func_a(__user void *a)
{
	func_b(a);
}

How about the other way, passing a normal pointer to a function with 
__user in its prototype?

I'm just worried that as soon as I use __user once, entire call chains 
are going to start spewing warnings/errors.

> Also, if your mailer doesn't rape whitespace, I
> seriously prefer patches in-line in the email, so that I don't have to
> edit the email and can reply to it directly?

I was under the impression that text/plain attachments were ok with 
you, but it looks like inline will work too.

-- 
Hollis Blanchard
IBM Linux Technology Center

