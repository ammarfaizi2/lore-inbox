Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVBYVTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVBYVTu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 16:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVBYVTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 16:19:49 -0500
Received: from [195.23.16.24] ([195.23.16.24]:60641 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261729AbVBYVTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 16:19:30 -0500
Message-ID: <421F9640.2070208@grupopie.com>
Date: Fri, 25 Feb 2005 21:18:56 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ARM undefined symbols.  Again.
References: <20050208194243.GA8505@mars.ravnborg.org> <20050208200501.B3544@flint.arm.linux.org.uk> <20050209104053.A31869@flint.arm.linux.org.uk> <20050213172940.A12469@flint.arm.linux.org.uk> <4210A345.6030304@grupopie.com> <20050225194823.A27842@flint.arm.linux.org.uk> <Pine.LNX.4.58.0502251158280.9237@ppc970.osdl.org> <20050225202349.C27842@flint.arm.linux.org.uk> <Pine.LNX.4.58.0502251227480.9237@ppc970.osdl.org> <421F90A0.7060404@grupopie.com> <20050225210254.GB15773@mars>
In-Reply-To: <20050225210254.GB15773@mars>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Fri, Feb 25, 2005 at 08:54:56PM +0000, Paulo Marques wrote:
> 
>>The patch (against 2.6.11-rc5) is attached, should you decide to use it.
> 
> How does the patch help rmk with respect to the tools issue?

 From the thread I gathered that the problem Russell King was having was 
caused by the fact that kallsyms used "weak" symbols.

He proposed a solution where he created an empty assembly file with just 
the symbols defined to make the symbols exist already on the first pass. 
This way they wouldn't have to be defined as weak anymore.

His patch created the assembly file using "echo's" from the Makefile. I 
just suggested that it would be better to do it from scripts/kallsyms.c 
directly, so that it would be easier to maintain in case new symbols 
need to be added in the future.

That's what this patch does.

By the way, I'm not really sure about my changes to the Makefile, 
although they comply with Linus Confidence Level 3(*). I think you're 
the one with the best understanding on the kbuild process to comment on 
them.

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)

(*) It works
