Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbTE1W5v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 18:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbTE1W5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 18:57:51 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:15774 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261454AbTE1W5X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 18:57:23 -0400
Message-ID: <3ED541CC.5010305@colorfullife.com>
Date: Thu, 29 May 2003 01:10:04 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: mikpe@csd.uu.se, pavel@suse.cz, miltonm@bga.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix oops on resume from apm bios initiated suspend
References: <200305280643.h4S6hRQF028038@sullivan.realtime.net>	<20030528111401.GB342@elf.ucw.cz>	<16084.46712.707240.943086@gargle.gargle.HOWL> <20030528152827.5387e033.akpm@digeo.com>
In-Reply-To: <20030528152827.5387e033.akpm@digeo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Also, is there any point in doing load_LDT(&current->active_mm->context)
>for a kernel thread?
>  
>
Yes.
If the next thread switch is to a user space process that uses 
kernel_thread->active_mm as user_thread->mm, then switch_to does not 
load the ldt. (switch_to, in <asm-i386/mmu_context.h>)
--
    Manfred

