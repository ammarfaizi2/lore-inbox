Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267423AbUBROZz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 09:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267425AbUBROZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 09:25:55 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:18390
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S267423AbUBROZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 09:25:51 -0500
Message-ID: <40337199.2060609@tmr.com>
Date: Wed, 18 Feb 2004 09:07:21 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: mail.linux-kernel
To: James Morris <jmorris@redhat.com>
CC: Jari Ruusu <jariruusu@users.sourceforge.net>,
       Jan Rychter <jan@rychter.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Oopsing cryptoapi (or loop device?) on 2.6.*
References: <402F877C.C9B693C1@users.sourceforge.net> <Xine.LNX.4.44.0402151924490.13809-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0402151924490.13809-100000@thoron.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:
> On Sun, 15 Feb 2004, Jari Ruusu wrote:
> 
> 
>>Jan Rychter wrote:
>>
>>>FWIW, I've just tried loop-AES with 2.4.24, after using cryptoapi for a
>>>number of years. My machine froze dead in the midst of copying 2.8GB of
>>>data onto my file-backed reiserfs encrypted loopback mount.
>>>
>>>Since the system didn't ever freeze on me before and since I've had zero
>>>problems with cryptoapi, I attribute the freeze to loop-AES.
>>>
>>>Yes, I know this isn't a good bugreport...
>>
>>Is there any particular reason why you insist on using file backed loops?
>>
>>File backed loops have hard to fix re-entry problem: GFP_NOFS memory
>>allocations that cause dirty pages to written out to file backed loop, will
>>have to re-enter the file system anyway to complete the write. This causes
>>deadlocks. Same deadlocks are there in mainline loop+cryptoloop combo.
> 
> 
> Given the security issues, and the above problems, we should probably just
> remove cryptoloop from the kernel and wait for something with a better
> design.

I hope you're kidding... one of the reasons for going to 2.6 is that you 
no longer have to patch your kernel to get cryptoloop. That is a real 
issue in some organizations, which only allow vendor or kernel.org kernels.

If you start dropping features which work for most people but aren't 
perfect, you will wind up with a microkernel indeed.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
