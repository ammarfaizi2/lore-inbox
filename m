Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263235AbTJON7i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 09:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263253AbTJON7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 09:59:38 -0400
Received: from leviathan.xo.com ([207.155.252.59]:44691 "EHLO leviathan.xo.com")
	by vger.kernel.org with ESMTP id S263235AbTJON7h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 09:59:37 -0400
Message-ID: <3F8D52CD.2000909@katana-technology.com>
Date: Wed, 15 Oct 2003 09:59:41 -0400
From: Larry Sendlosky <lsendlosky@katana-technology.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: mem=16MB laptop testing
References: <20031014105514.GH765@holomorphy.com> <20031014045614.22ea9c4b.akpm@osdl.org> <20031015121208.GA692@elf.ucw.cz> <20031015125109.GQ16158@holomorphy.com> <20031015132054.GA840@elf.ucw.cz> <20031015132824.GS16158@holomorphy.com>
In-Reply-To: <20031015132824.GS16158@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 1.403.15.8 2002/6/05 davej@suse.de
[PATCH] large x86 setup cleanup.

Patrick Mochel did a great job here at splitting up some of the larger
messy parts of arch/i386/kernel/setup.c, and introduced a nice abstraction
which gives us a much nicer way to ensure we can add workarounds for vendor
specific bugs / features without polluting other vendor code paths.

Mark Haverkamp also brought this up to date for merging in my tree circa
2.5.14, and asides from 1-2 now fixed small thinkos, there haven't been
any problems.

This also features a workaround for an errata item on stepping C0 of
the Intel Pentium 4 Xeon, which isn't in your tree yet, where we must
disable the hardware prefetcher to ensure sane operation.

arch/i386/kernel/setup.c 1.41.1.16 2002/06/03 10:10:19 davej@suse.de
large x86 setup cleanup.




William Lee Irwin III wrote:

>On Wed, Oct 15, 2003 at 03:20:54PM +0200, Pavel Machek wrote:
>  
>
>>Do you want to say that calculation is different, already? We should
>>probably make 2.5 version match 2.4 version, that's what users
>>expect. Who changed it and why?
>>    
>>
>
>No idea when it changed, but I was at least duly disturbed by the tiny
>384KB ZONE_NORMAL materializing out of thin air when I booted mem=16m.
>
>
>-- wli
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>.
>
>  
>

