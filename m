Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265351AbUFBGGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265351AbUFBGGP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 02:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265343AbUFBGGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 02:06:14 -0400
Received: from mailout.despammed.com ([65.112.71.29]:14513 "EHLO
	mailout.despammed.com") by vger.kernel.org with ESMTP
	id S265351AbUFBGGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 02:06:12 -0400
Date: Wed, 2 Jun 2004 00:52:57 -0500 (CDT)
Message-Id: <200406020552.i525qvk08725@mailout.despammed.com>
From: ndiamond@despammed.com
To: linux-kernel@vger.kernel.org
Subject: Re: How to use floating point in a module?
X-Mailer: despammed.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin replied to me:

>> (The CPU is an i686. I'll have to look up its opcodes and see if its
>> hardware will come close enough for everything the driver needs. If it
>> doesn't, I'll buy one of the books that some others kindly recommended
>> and do polynomial approximations.)
>
> On x86 (more specifically, on x87) if you can do it at all then you
> can do them all.

I'm not quite sure what that means.  It was pretty easy to code a log2()
function using the built-in opcode, but it took me nearly a day to code
an exp2() function.  The built-in f2xm1 opcode helps a lot but there's
no help for the other half exp2()'s lot.

I'm sure you and other x86 assembly experts can improve on this if
you ever have any need for it.  The only consolation I get is that
for some reason gcc does library calls for log10 and pow.  It would be
really trivial to inline log10, though maybe pow is too big to benefit
from inlining.
