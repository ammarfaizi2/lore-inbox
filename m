Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbUGHPAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbUGHPAI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 11:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263117AbUGHPAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 11:00:08 -0400
Received: from sanosuke.troilus.org ([66.92.173.88]:54741 "EHLO
	sanosuke.troilus.org") by vger.kernel.org with ESMTP
	id S262106AbUGHPAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 11:00:04 -0400
To: root@chaos.analogic.com
Cc: "P. Benie" <pjb1008@eng.cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
	<E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>
	<Pine.LNX.4.53.0407080707010.21439@chaos>
	<Pine.HPX.4.58L.0407081224460.28859@punch.eng.cam.ac.uk>
	<Pine.LNX.4.53.0407081030320.21855@chaos>
From: Michael Poole <mdpoole@troilus.org>
Date: Thu, 08 Jul 2004 11:00:02 -0400
In-Reply-To: <Pine.LNX.4.53.0407081030320.21855@chaos> (Richard B. Johnson's
 message of "Thu, 8 Jul 2004 10:32:32 -0400 (EDT)")
Message-ID: <87hdsih7d9.fsf@sanosuke.troilus.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson writes:

> On Thu, 8 Jul 2004, P. Benie wrote:
>
>> False. "An integer constant expressions with the value 0, or such an
>> expression cast to type void *, is called a null pointer constant. If a
>> null pointer constant is assigned to or compared for equality with a
>> pointer, the constant is converted to a pointer of that type", and "Any
>> two null pointers shall compare equal."
>>
>> In other words, when you use 0 as a null pointer, you really do get a null
>> pointer. If you are working on an architecture where the bit pattern of
>> the integer 0 and null pointers are not the same, the compiler will
>> perform the appropriate conversion for you, so it is always correct to
>> define NULL as (void *)0.
>
> That's NOT what is says. It states that a NULL pointer is converted to
> the appropriate type before any comparison is made. It does NOT say
> that 0 is a valid null-pointer.

Could you please elaborate the rules of English in which "An integer
constant expresion with the value 0 [...] is called a null pointer
constant" does not mean that 0 is a null pointer?  0 is certainly an
integer constant expression with the value 0, so there must be
something extraordinarily subtle in the second half of the sentence.

Michael
