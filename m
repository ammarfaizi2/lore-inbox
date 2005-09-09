Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbVIIMl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbVIIMl1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 08:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbVIIMl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 08:41:27 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:6873 "EHLO gw1.cosmosbay.com")
	by vger.kernel.org with ESMTP id S1751397AbVIIMlX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 08:41:23 -0400
Message-ID: <432182E2.2060105@cosmosbay.com>
Date: Fri, 09 Sep 2005 14:41:06 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Philippe Elie <phil.el@wanadoo.fr>
CC: Andi Kleen <ak@suse.de>, Jan Beulich <JBeulich@novell.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] [PATCH] allow CONFIG_FRAME_POINTER for x86-64
References: <43207D28020000780002451E@emea1-mh.id2.novell.com> <200509091054.11932.ak@suse.de> <43216EFB020000780002489B@emea1-mh.id2.novell.com> <200509091123.59205.ak@suse.de> <20050909110702.GA787@zaniah>
In-Reply-To: <20050909110702.GA787@zaniah>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Fri, 09 Sep 2005 14:41:09 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philippe Elie a écrit :
> On Fri, 09 Sep 2005 at 11:23 +0000, Andi Kleen wrote:
> 
>  
> 
>>Indeed. Someone must have fixed it.  But why would anyone want frame pointers
>>on x86-64?
> 
> 
> Oprofile can use it, I though it was already used but apparently only
> to backtrace userspace actually.
> 
Hi Pilippe

Last time I tried oprofile with call graph on my opteron machine (linux-2.6.13 
SMP), the machine crashed instantly in dump_backtrace()

Apparently the user program was in a state were 'struct frame_head * head' was 
  not part of the user thread stack, but some strange value like 
0x8000000000xxyyzz

Eric
