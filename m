Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbWEORxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbWEORxV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWEORxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:53:21 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:65437 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S965007AbWEORxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:53:20 -0400
Date: Mon, 15 May 2006 19:53:06 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] x86 NUMA panic compile error
Message-ID: <20060515175306.GA18185@elte.hu>
References: <20060515005637.00b54560.akpm@osdl.org> <20060515140811.GA23750@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060515140811.GA23750@shadowen.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Whitcroft <apw@shadowen.org> wrote:

>  	if (use_cyclone == 0) {
>  		/* Make sure user sees something */
> -		static const char s[] __initdata = "Not an IBM x440/NUMAQ. Don't use i386 CONFIG_NUMA anywhere else."
> +		static const char s[] __initdata = "Not an IBM x440/NUMAQ. Don't use i386 CONFIG_NUMA anywhere else.";
>  		early_printk(s);
>  		panic(s);
>  	}

i still strongly oppose the original Andi hack... numerous reasons were 
given not to apply it (it's nice to simulate/trigger rarer features on 
mainstream hardware too, and this ability to boot NUMA on my flat x86 
testbox found at least one other NUMA bug already). Furthermore, the 
crash i reported was fixed by the NUMA patchset. Andrew, please drop:

  x86_64-mm-i386-numa-summit-check.patch

(which has nothing to do with x86_64 anyway)

	Ingo
