Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbUD3UvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUD3UvH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 16:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265255AbUD3Uow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 16:44:52 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:55463 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S263302AbUD3UjE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 16:39:04 -0400
In-Reply-To: <Pine.LNX.4.58.0404301319020.18014@ppc970.osdl.org>
References: <009701c42edf$25e47390$ca41cb3f@amer.cisco.com> <Pine.LNX.4.58.0404301212070.18014@ppc970.osdl.org> <90DD8A88-9AE2-11D8-B83D-000A95BCAC26@linuxant.com> <Pine.LNX.4.58.0404301319020.18014@ppc970.osdl.org>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <69A8B470-9AE6-11D8-B83D-000A95BCAC26@linuxant.com>
Content-Transfer-Encoding: 7bit
Cc: "'Sean Estabrooks'" <seanlkml@rogers.com>,
       "'Paul Wagland'" <paul@wagland.net>, "'Rik van Riel'" <riel@redhat.com>,
       "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "'Peter Williams'" <peterw@aurema.com>, Hua Zhong <hzhong@cisco.com>,
       "'Timothy Miller'" <miller@techsource.com>,
       "'lkml - Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       koke@sindominio.net, "'Rusty Russell'" <rusty@rustcorp.com.au>,
       "'David Gibson'" <david@gibson.dropbear.id.au>
From: Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Fri, 30 Apr 2004 16:39:01 -0400
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Apr 30, 2004, at 4:26 PM, Linus Torvalds wrote:
>
> On Fri, 30 Apr 2004, Marc Boucher wrote:
>>
>>> In contrast, wine was _written_ to do this emulation, so by 
>>> definition
>>> any
>>> "bugs" are in wine itself (although I suspect that wine people
>>> sometimes
>>> would prefer it if Office came with sources ;).
>>
>> The same can be said about DriverLoader.
>
> .. but not abotu the kernel that it depends on.
>
> In other words, if driverloader was a stand-alone project, you could do
> whatever the hell you wanted with it.

To clarify this important point, driverloader is a standalone project, 
and structured similarly to the HSF driver (all os-specific code is 
open-source allowing it to be used with any kernel or even 
theoretically any other x86 operating system).

Because only one logical module is loaded, and a single set of tainted 
messages bearable, the \0 MODULE_LICENSE() workaround is unnecessary 
and not used in driverloader.

Marc

