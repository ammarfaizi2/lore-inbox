Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbUCXWu3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 17:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbUCXWu3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 17:50:29 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:38559 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S262493AbUCXWu2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 17:50:28 -0500
Date: Thu, 25 Mar 2004 06:46:12 +0800
From: "Michael Frank" <mhf@linuxmail.org>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]
Cc: "Nigel Cunningham" <ncunningham@users.sourceforge.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Swsusp mailing list" <swsusp-devel@lists.sourceforge.net>,
       "Andrew Morton" <akpm@osdl.org>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au> <20040323095318.GB20026@hmmn.org> <20040323214734.GD364@elf.ucw.cz> <200403231743.01642.dtor_core@ameritech.net> <20040323233228.GK364@elf.ucw.cz> <1080081653.22670.15.camel@calvin.wpcb.org.au> <20040323234449.GM364@elf.ucw.cz> <opr5ci61g54evsfm@smtp.pacific.net.th> <20040324101704.GA512@elf.ucw.cz>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr5d1jave4evsfm@smtp.pacific.net.th>
In-Reply-To: <20040324101704.GA512@elf.ucw.cz>
User-Agent: Opera M2/7.50 (Linux, build 615)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

May I request that you leave the authors headers intact when quoting. Thank you.

On Wed, 24 Mar 2004 11:17:04 +0100, Pavel Machek <pavel@ucw.cz> wrote:

>> >>So why aren't you arguing against bootsplash too? That definitely
>> >>obscures such an error :> Of course we could argue that such an error
>> >>shouldn't happen and/or will be obvious via other means (assuming it
>> >>indicates hardware failure).
>> >
>> >Of course I *am* against bootsplash. Unfortunately I've probably lost
>> >that war already. But at least it is not in -linus tree (and that's
>> >what I use anyway) => I gave up with bootsplash-equivalents, as long
>> >as they don't come to linus.
>> >
>> >[And I believe Linus would shoot down bootsplash-like code, anyway.]

Why? Joe consumer wants it.

As to the ever growing size of the kernel, there could be a official addons/tools
tree with non-core functions maintained by a seperate maintainer. Things like
debuggers, profiling or (swsusp) debug support could go there as well...

>>
>> Solution: Auto switch to non-swsusp VT on error showing the error message.
>
> Hmm, at that point you loose context, like now you know what error
> happened, but do not know at which phase of suspend. That's pretty bad
> too.

Right, Good idea!  Just  print always "ugly" swsusp context on a text VT - plus any
error messages  - and switch over to this VT in printk when not in interrupt
context. 10 lines of code or so in printk ;)

Michael





