Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbULGQU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbULGQU3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 11:20:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbULGQU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 11:20:29 -0500
Received: from fire.osdl.org ([65.172.181.4]:2215 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261851AbULGQUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 11:20:21 -0500
Message-ID: <41B5CF78.4030206@osdl.org>
Date: Tue, 07 Dec 2004 07:42:48 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Bug in kmem_cache_create with duplicate names
References: <1102434056.25841.260.camel@localhost.localdomain>	 <41B5CD41.9050102@osdl.org> <1102436157.2882.8.camel@laptop.fenrus.org>
In-Reply-To: <1102436157.2882.8.camel@laptop.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, 2004-12-07 at 07:33 -0800, Randy.Dunlap wrote:
> 
>>Steven Rostedt wrote:
>>
>>>Is it really necessary to BUG on creating a cache with a duplicate name?
>>>Wouldn't it just be better to fail the create. The reason I mentioned
>>>this is that I was writing some modules and after doing a cut and paste,
>>>I forgot to change a name of a cache that was created by one module and
>>>I used it in another existing module.  So you can say that it was indeed
>>>a bug, but did it really need to crash my machine?  I aways check the
>>>return codes in my modules, and I would have figured it out why it
>>>failed, but I didn't expect a simple module to crash the machine the way
>>>it did.  Well anyway it did definitely show me where my bug was.
>>
>>Yes, it does that.
>>
>>However, I agree with you.  I don't see a good reason for it.
> 
> 
> I do...
> because if the registration gives success..... then you unregister it
> later during module unload and the INITIAL user goes bang.
> It's a bad bug. Don't do it. Fix your code ;)

Who said anything about the (second) registration giving success?
and how is it destroyed without a valid ptr to it?

-- 
~Randy
