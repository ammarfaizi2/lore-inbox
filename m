Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276840AbRJIMND>; Tue, 9 Oct 2001 08:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276950AbRJIMMx>; Tue, 9 Oct 2001 08:12:53 -0400
Received: from s2.relay.oleane.net ([195.25.12.49]:20499 "HELO
	s2.relay.oleane.net") by vger.kernel.org with SMTP
	id <S276840AbRJIMMn>; Tue, 9 Oct 2001 08:12:43 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Keith Owens <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] change name of rep_nop 
Date: Tue, 9 Oct 2001 14:13:22 +0200
Message-Id: <20011009121322.2426@smtp.adsl.oleane.com>
In-Reply-To: <30619.1002627002@ocs3.intra.ocs.com.au>
In-Reply-To: <30619.1002627002@ocs3.intra.ocs.com.au>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>One approach we take on PPC that you may or may not like for this is
>>dynamic patching.
>
>BIG RED WARNING: Anybody thinking of using dynamic patching must
>consider modules as well as the kernel.  modutils 2.4.8 added support
>for ppc archdata to allow dynamic patching of modules using the ftr
>data.  There also has to be code in kernel/module.c::module_arch_init()
>to take the archdata and do whatever is required.
>
>If anybody starts doing dynamic patching, please let me know so I can
>handle modutils and module_arch_init().

Yes, definitely an issue. The mecanism we used on PPC was so specific
to some low-level arch asm code that modules were a non-issue... until
some of that critical code ended up beeing inlined.

Ben.


