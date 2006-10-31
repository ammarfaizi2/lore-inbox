Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423548AbWJaQP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423548AbWJaQP3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 11:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423550AbWJaQP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 11:15:29 -0500
Received: from smtp-out.google.com ([216.239.45.12]:49219 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1423548AbWJaQP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 11:15:28 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:mime-version:to:cc:
	subject:references:in-reply-to:content-type:content-transfer-encoding;
	b=BKND9n/zVFfGETvaLz1wi8KGUFV8n3pmSsz1l6hJ4FOmJpjfZ2BqwwhgYg4wFNoea
	bnkH6UZTkrbQvj8u9a62g==
Message-ID: <45477668.4070801@google.com>
Date: Tue, 31 Oct 2006 08:14:32 -0800
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Subject: Re: Linux 2.6.19-rc4
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <20061030213454.8266fcb6.akpm@osdl.org> <Pine.LNX.4.64.0610310737000.25218@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610310737000.25218@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But I've become innoculated against warnings, just because we have too 
> many of the totally useless noise about deprecation and crud, and ppc has 
> it's own set of bogus compiler-and-linker-generated warnings..
> 
> At some point we should get rid of all the "politeness" warnings, just 
> because they can end up hiding the _real_ ones.

Yay! Couldn't agree more. Does this mean you'll take patches for all the
uninitialized variable crap from gcc 4.x ?

> "pm_register is deprecated" etc - I get almost a hundred lines of warnings 
> in my default build (and half of those are sadly due to powerpc binutils, 
> that I can't do anythign about: "section .init.text exceeds stub group 
> size" etc, which is harmless _other_ than the fact that it helped hide the 
> real warnings just because I've grown too used to not looking too 
> closely).

Doesn't turning off CONFIG_PM_LEGACY fix those? it did for me.

M.

PS. I still think -Werror is a good plan. But I acknowledge that's
fairly extreme.
