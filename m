Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160995AbWHAUMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160995AbWHAUMR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 16:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161017AbWHAUMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 16:12:17 -0400
Received: from mail.tmr.com ([64.65.253.246]:27281 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S1160995AbWHAUMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 16:12:16 -0400
Message-ID: <44CFB66E.1080500@tmr.com>
Date: Tue, 01 Aug 2006 16:15:42 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
Newsgroups: gmane.linux.kernel
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: single bit flip detector.
References: <20060801184451.GP22240@redhat.com>
In-Reply-To: <20060801184451.GP22240@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

eventuallyDave Jones wrote:
> In case where we detect a single bit has been flipped, we spew
> the usual slab corruption message, which users instantly think
> is a kernel bug.  In a lot of cases, single bit errors are
> down to bad memory, or other hardware failure.
> 
> This patch adds an extra line to the slab debug messages
> in those cases, in the hope that users will try memtest before
> they report a bug.
> 
> 000: 6b 6b 6b 6b 6a 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
> Single bit error detected. Possibly bad RAM. Run memtest86.

Given the probability of hardware vs. kernel, you could replace 
"possible" with "probable" and not get any argument from me.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
