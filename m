Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262288AbRFNRgh>; Thu, 14 Jun 2001 13:36:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263434AbRFNRg1>; Thu, 14 Jun 2001 13:36:27 -0400
Received: from [64.64.109.142] ([64.64.109.142]:30221 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S262288AbRFNRgQ>; Thu, 14 Jun 2001 13:36:16 -0400
Message-ID: <3B28F5B2.80458694@didntduck.org>
Date: Thu, 14 Jun 2001 13:34:42 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Marty Leisner <mleisner@eng.mc.xerox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: what's the purpose of SYMBOL_NAME()
In-Reply-To: <200106141657.MAA09198@mailhost.eng.mc.xerox.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marty Leisner wrote:
> 
> I'm read Bovet's "Understand the Linux Kernel"
> and looked at the assembly routine setup_idt...
> 
> I noticed the assembly has SYMBOL_NAME
> (its all over the place).
> 
> This is define in include/linux/linkage.h
> 
> to just:
> #define SYMBOL_NAME(X) X
> 
> (this wasn't in Bovet's book).
> 
> What's the purpose?

IIRC, it's a holdover from the days when the kernel could be compiled in
a.out and ELF format.  a.out prepends an underscore to all symbols,
whereas ELF does not.

--

				Brian Gerst
