Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbVKWVHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbVKWVHn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 16:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbVKWVHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 16:07:43 -0500
Received: from relay02.mail-hub.dodo.com.au ([202.136.32.45]:54490 "EHLO
	relay02.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932416AbVKWVHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 16:07:43 -0500
From: Grant Coady <grant_lkml@dodo.com.au>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Ashutosh Naik <ashutosh.lkml@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Over-riding symbols in the Kernel causes Kernel Panic
Date: Thu, 24 Nov 2005 08:07:34 +1100
Organization: http://bugsplatter.mine.nu/
Reply-To: gcoady@gmail.com
Message-ID: <9em9o1d5fao3b1dc6dql7idgkrhsbaru77@4ax.com>
References: <c216304e0511230610x2b983e59h42c10517acd59e63@mail.gmail.com> <4384AAED.3070804@tmr.com> <9a8748490511231004l36edcf57mf0fb63c4a9e17f49@mail.gmail.com>
In-Reply-To: <9a8748490511231004l36edcf57mf0fb63c4a9e17f49@mail.gmail.com>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2005 19:04:41 +0100, Jesper Juhl <jesper.juhl@gmail.com> wrote:

>On 11/23/05, Bill Davidsen <davidsen@tmr.com> wrote:
>> Ashutosh Naik wrote:
>> > Hi,
>> >
>> > I made e1000 ( or for that matter anything) a part of the 2.6.15-rc1
>> > kernel and booted the kernel. Next I compiled e1000 as a module (
>> > e1000.ko ), and tried to insmod it into the kernel( which already had
>> > e1000 a compiled as a part of the kernel). I observed that
>> > /proc/kallsyms contained two copies of all the symbols exported by
>> > e1000, and I also got a Kernel Panic on the way.
>> >
>> > Is this behaviour natural and desirable ?
>>
>> No, trying to insert a module into a kernel built with the functionality
>> compiled in is a vile perverted act, and probably illegal in Republican
>> states! ;-)
>>
>> The other day I mentioned that reiser4 will find bugs because people
>> will do bizarre things with it when it is more widely used. I think you
>> have hit a "no one would ever do that" bug in the module loader, and
>> demonstrated my point in the process.
>>
>> The panic isn't desirable, but I'm not sure what "correct behaviour"
>> would be, I can't imagine that this is intended to work. The issues of
>> removing such a module gracefully are significant.
>
>Wouldn't the desired behaviour be that when the kernel attempts to
>load a module it checks if it is already present build-in and if so
>simply refuse to load it at all?

But that sounds just too easy to implement, what's the catch?  :o)
-- 
Grant.
