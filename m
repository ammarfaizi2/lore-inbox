Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265492AbUHOAVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265492AbUHOAVZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 20:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265521AbUHOAVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 20:21:25 -0400
Received: from [195.23.16.24] ([195.23.16.24]:60584 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S265492AbUHOAVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 20:21:23 -0400
Message-ID: <411EAC81.2030703@grupopie.com>
Date: Sun, 15 Aug 2004 01:21:21 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
Cc: Ingo Molnar <mingo@elte.hu>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] Latency Tracer, voluntary-preempt-2.6.8-rc4-O6
References: <8634.1092485844@ocs3.ocs.com.au>
In-Reply-To: <8634.1092485844@ocs3.ocs.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.4; VDF: 6.27.0.10; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> On Sat, 14 Aug 2004 05:50:50 +0100, 
> Paulo Marques <pmarques@grupopie.com> wrote:
> 
>>Well, I found some time and decided to give it a go :)
> 
> 
> This patch regresses some recent changes to kallsyms which handle
> aliased symbols, IOW symbols with the same address.  The speed up is
> very good, but it has two problems with repeated addresses.

Oops, I didn't realize that there could be repeated addresses :(

I did a test running 500000 lookups with the original function and my 
own and compared the results from both functions looking for any 
differences. The test program was fed from /proc/kallsyms from my 
machine. Because there were no aliases there, the result was ok and I 
felt confident about the algorithm.

Anyway, at first glance your patch looks right, and I don't think there 
will be any performance implications from it, unless there can be 
thousands of aliases for the same address :)

-- 
Paulo Marques - www.grupopie.com

