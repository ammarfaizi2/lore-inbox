Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270040AbTGXTgS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 15:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270047AbTGXTgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 15:36:18 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:63904 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S270040AbTGXTgR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 15:36:17 -0400
Date: Thu, 24 Jul 2003 14:51:16 -0500
Subject: Re: [uClinux-dev] Kernel 2.6 size increase - get_current()?
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: David McCullough <davidm@snapgear.com>, uclinux-dev@uclinux.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Ihar \"Philips\" Filipau" <filia@softhome.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Hollis Blanchard <hollisb@us.ibm.com>
In-Reply-To: <1059075436.7998.58.camel@dhcp22.swansea.linux.org.uk>
Message-Id: <3038B2BC-BE10-11D7-B453-000A95A0560C@us.ibm.com>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.552)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, Jul 24, 2003, at 14:37 US/Central, Alan Cox wrote:

> On Iau, 2003-07-24 at 16:30, Hollis Blanchard wrote:
>> So you're arguing for more inlining, because icache speculative
>> prefetch will pick up the inlined code?
>
> I'm arguing for short inlined fast paths and non inlined unusual
> paths.
>
>> Or you're arguing for less, because code like get_current() which is
>> called frequently could have a single copy living in icache?
>
> Depends how much the jump costs you.

And also how big your icache is, and maybe even cpu/bus ratio, etc... 
which depend on the arch of course.

So as I saw Ihar suggest earlier in this thread, perhaps there should 
be two inline directives: must_inline (for code whose correctness 
depends on it) and could_help_performance_inline. Then different archs 
could #define could_help_performance_inline as appropriate.

-- 
Hollis Blanchard
IBM Linux Technology Center

