Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275175AbRIZN3q>; Wed, 26 Sep 2001 09:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275174AbRIZN3g>; Wed, 26 Sep 2001 09:29:36 -0400
Received: from quark.didntduck.org ([216.43.55.190]:29445 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S275183AbRIZN3Y>; Wed, 26 Sep 2001 09:29:24 -0400
Message-ID: <3BB1D836.BD0166AB@didntduck.org>
Date: Wed, 26 Sep 2001 09:29:26 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: cwidmer@iiic.ethz.ch
CC: linux-kernel@vger.kernel.org
Subject: Re: stack overflow?
In-Reply-To: <200109261003.f8QA3cg22792@mail.swissonline.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Widmer wrote:
> 
> hi
> 
> i saw very strange behaviour when debuging my modules and i start to think
> about stack overflow. i know that the kernel stack of eache process is some
> what smaller than 8KB. but how big is the kernelstack during interrupt time
> when executing tasklets?

Depends on the architecture, but on the x86 there is no stack switch
when you receive an interrupt in kernel mode.  Thus, if too many
interrupts occur you could potentially overflow the stack.  If
interrupted from user mode the stack switches to the top of the kernel
stack.

--

				Brian Gerst
