Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWEaUQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWEaUQL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 16:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWEaUQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 16:16:11 -0400
Received: from mail.tmr.com ([64.65.253.246]:54465 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S1751292AbWEaUQJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 16:16:09 -0400
Message-ID: <447DF9F6.3060302@tmr.com>
Date: Wed, 31 May 2006 16:17:58 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.2) Gecko/20060405 SeaMonkey/1.0.1
MIME-Version: 1.0
To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Adaptive read-ahead V12
References: <348628455.03454@ustc.edu.cn>
In-Reply-To: <348628455.03454@ustc.edu.cn>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang wrote:
> ----- Forwarded message from Iozone <capps@iozone.org> -----
> 
> Subject: Adaptive read-ahead V12
> From: Iozone <capps@iozone.org>
> To: Wu Fengguang <wfg@mail.ustc.edu.cn>
> X-Mailer: Microsoft Outlook Express 6.00.2900.2670
> Date: Thu, 25 May 2006 11:44:37 -0500
> 
> Wu Fengguang,
> 
>        I see that Andrew M. is giving you some pushback.... 
>    His argument is that the application could do a better job
>    of scheduling its own read-ahead.  ( I've heard this one 
>    before)
> 
>    My thoughts on this argument would be along the 
>    lines of:
> 
>    Indeed the application might be able to do a better
>    job, however expecting, or demanding, the rewrite
>    of all applications to behave better might be an unreasonable
>    expectation. 

A reasonable expectation would be that the application would have a way 
to tell the kernel to ignore readahead for a given file, other than 
changing the behavior of the kernel as a whole for all processes on the 
machine. This smart application could then use aio or some other similar 
method to do preread itself.

My personal opinion is that the kernel only does a good job reading 
ahead for sequential access, and since that's the common case only a 
means of preventing that effort need be provided.

I can think of several ways the kernel might be smarter about the way it 
reads (or not) random access, but since I have no way to test them on 
applications other than my own I won't belabor them here.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.

