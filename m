Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbTI1SaF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 14:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262667AbTI1SaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 14:30:05 -0400
Received: from front1.chartermi.net ([24.213.60.123]:21130 "EHLO
	front1.chartermi.net") by vger.kernel.org with ESMTP
	id S262666AbTI1SaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 14:30:02 -0400
Message-ID: <3F7728A8.5030602@quark.didntduck.org>
Date: Sun, 28 Sep 2003 14:30:00 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 do_machine_check() is redundant.
References: <Pine.LNX.4.44.0309281121470.15408-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0309281121470.15408-100000@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On Sun, 28 Sep 2003, Brian Gerst wrote:
> 
>>Use machine_check_vector in the entry code instead.
> 
> 
> This is wrong. You just lost the "asmlinkage" thing, which means that it 
> breaks when asmlinkage matters.
> 
> And yes, asmlinkage _can_ matter, even on x86. It disasbles regparm, for
> one thing, so it makes a huge difference if the kernel is compiled with
> -mregparm=3 (which used to work, and which I'd love to do, but gcc has
> often been a tad fragile).
> 
> 		Linus
> 

Good point.  Wouldn't it just be better to change the few handlers to 
asmlinkage instead?  Having that stub function there is pointless.

--
				Brian Gerst

