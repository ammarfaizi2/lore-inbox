Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVAKRyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVAKRyn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 12:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVAKRxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 12:53:54 -0500
Received: from fire.osdl.org ([65.172.181.4]:52456 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S261285AbVAKRmA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 12:42:00 -0500
Message-ID: <41E40F4A.6020500@osdl.org>
Date: Tue, 11 Jan 2005 09:39:22 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Dave <dave.jiang@gmail.com>, linux-kernel@vger.kernel.org,
       smaurer@teja.com, linux@arm.linux.org.uk, dsaxena@plexity.net,
       drew.moseley@intel.com
Subject: Re: clean way to support >32bit addr on 32bit CPU
References: <8746466a050110153479954fd2@mail.gmail.com> <Pine.LNX.4.58.0501101607240.2373@ppc970.osdl.org> <41E31D95.50205@osdl.org> <Pine.LNX.4.58.0501101722200.2373@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501101722200.2373@ppc970.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 10 Jan 2005, Randy.Dunlap wrote:
> 
>>Speaking of fall-out, or more like trickle-down,
>>I'm almost done with a patch to make PCMCIA resources use
>>unsigned long instead of u_int or u_short for IO address:
> 
> Ahh, yes. That's required on pretty much all platforms except x86 and
> x86-64.

OK, I don't get it, sorry.  What's different about ARM & MIPS here
(for PCMCIA)?  Is this historical (so that I'm just missing it)
or is it a data types difference?

> Of course, since ARM and MIPS already do the "u_int" thing, and not a 
> whole lot of other architectures do PCMCIA, I guess it doesn't matter 
> _that_ much. Cardbus stuff should get it right regardless.
> 
> 
>>typedef unsigned long	ioaddr_t;
>>
>>and then include/pcmcia/cs.c needs some changes in use of
>>ioaddr_t, along with drivers (printk formats).
>>
>>Does that sound OK?
>>I guess that it would become unsigned long long (or u64)
>>with this proposal?
> 
> 
> I don't think ioaddr_t needs to match resources. None of the IO accessor
> functions take "u64"s anyway - and aren't likely to do so in the future
> either - so "unsigned long" should be good enough.

Thanks,
-- 
~Randy
