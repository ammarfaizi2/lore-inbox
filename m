Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbTFTBxv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 21:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262148AbTFTBxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 21:53:51 -0400
Received: from [81.193.96.95] ([81.193.96.95]:11432 "HELO
	puma-vgertech.no-ip.com") by vger.kernel.org with SMTP
	id S262145AbTFTBxt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 21:53:49 -0400
Message-ID: <3EF26C85.5090507@vgertech.com>
Date: Fri, 20 Jun 2003 03:08:05 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030527 Debian/1.3.1-2
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Samphan Raruenrom <samphan@thai.com>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: Crusoe's persistent translation on linux?
References: <Pine.LNX.4.44.0306191707000.1987-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0306191707000.1987-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Linus Torvalds wrote:
> On Fri, 20 Jun 2003, Nuno Silva wrote:
> 
>>This raises a new question. How about a port of Linux to the "VLIW" so 
>>that we can skip x86 "code morphing" interelly?
> 
> 
> The native crusoe code - even if it was documented and available - is not 
> very conductive to general-purpose OS stuff. It has no notion of memory 
> protection, and there's no MMU for code accesses, so things like kernel 
> modules simply wouldn't work.
> 
> 
>>I'm sure that 1GHz would benefit from it. Is it possible, Linus?
> 
> 
> The translations are usually _better_ than statically compiled native 
> code (because the whole CPU is designed for speculation, and the static 
> compilers don't know how to do that), and thus going to native mode is not 
> necessarily a performance improvement.
> 
> So no, it wouldn't really benefit from it, not to mention that it's not
> even an option since Transmeta has never released enough details to do it
> anyway. Largely for simple security concerns - if you start giving
> interfaces for mucking around with the "microcode", you could do some
> really nasty things. 


Authoritative answer received! :)

Thanks,
Nuno Silva


> 
> Process startup is slightly slower due to the translation overhead, but
> that doesn't matter for the kernel anyway (so a native kernel wouldn't
> much help). And we do cache translations in memory, even across
> invocations. I suspect the reason large builds are slower are due to slow
> memory and/or occasionally overflowing the translation cache.
> 
> 			Linus
> 
> 




