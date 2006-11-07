Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754174AbWKGKQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174AbWKGKQU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 05:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754176AbWKGKQT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 05:16:19 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:32226 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1754174AbWKGKQS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 05:16:18 -0500
Date: Tue, 7 Nov 2006 13:15:06 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Vasily Averin <vvs@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: Re: 2.6.19-rc3-mm1: compilation fails if CONFIG_KEVENT is disabled
Message-ID: <20061107101506.GA26943@2ka.mipt.ru>
References: <45487246.2080309@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <45487246.2080309@sw.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Tue, 07 Nov 2006 13:15:41 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 01:09:10PM +0300, Vasily Averin (vvs@sw.ru) wrote:
> arch/i386/kernel/built-in.o(.rodata+0x520): In function `sys_call_table':
> : undefined reference to `sys_kevent_get_events'
> arch/i386/kernel/built-in.o(.rodata+0x524): In function `sys_call_table':
> : undefined reference to `sys_kevent_ctl'
> arch/i386/kernel/built-in.o(.rodata+0x528): In function `sys_call_table':
> : undefined reference to `sys_kevent_wait'
> make: *** [.tmp_vmlinux1] Error 1
> [linux-2.6.19-rc3-mm1]$ grep KEVENT .config
> CONFIG_GENERIC_CLOCKEVENTS=y
> # CONFIG_KEVENT is not set

Could you send output of
cat kernel/sys_ni.c | grep kevent 
there should be all above syscalls, but it looks like they are not.

P.S. I will remove devel@openvz.org from Cc: next time since it does not 
allow posts from not subscribed people.

-- 
	Evgeniy Polyakov
