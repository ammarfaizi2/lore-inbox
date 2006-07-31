Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030283AbWGaUlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030283AbWGaUlr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 16:41:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbWGaUlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 16:41:47 -0400
Received: from terminus.zytor.com ([192.83.249.54]:8852 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030283AbWGaUlq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 16:41:46 -0400
Message-ID: <44CE6AEA.2090909@zytor.com>
Date: Mon, 31 Jul 2006 13:41:14 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86_64 built-in command line
References: <20060731171442.GI6908@waste.org> <200607312207.58999.ak@suse.de>
In-Reply-To: <200607312207.58999.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>   
>> +#ifdef CONFIG_CMDLINE_BOOL
>> +	strlcpy(saved_command_line, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
>> +#endif
> 
> I think I would prefer a strcat.
> 
> Also you should describe the exact behaviour (override/append) in Kconfig help.
> 

In the i386 thread, Matt described having a firmware bootloader which 
passes bogus parameters.  For that case, it would make sense to have a 
non-default CONFIG option to have override rather than conjoined (and I 
maintain that the built-in command line should be prepended.)

	-hpa

