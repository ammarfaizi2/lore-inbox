Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261264AbVEDSLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261264AbVEDSLE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 14:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbVEDSLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 14:11:04 -0400
Received: from deliverator7.gatech.edu ([130.207.165.169]:53120 "EHLO
	deliverator7.gatech.edu") by vger.kernel.org with ESMTP
	id S261264AbVEDSKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 14:10:47 -0400
To: Brian Gerst <bgerst@didntduck.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: macro in linux/compiler.h pollutes gcc __attribute__ namespace
References: <87vf5y99o3.fsf@mail.gatech.edu> <42790A86.9070002@didntduck.org>
From: Timmy Douglas <timmy+lkml@cc.gatech.edu>
Date: Wed, 04 May 2005 14:10:21 -0400
In-Reply-To: <42790A86.9070002@didntduck.org> (Brian Gerst's message of "Wed,
	04 May 2005 13:46:46 -0400")
Message-ID: <87fyx2vp4i.fsf@mail.gatech.edu>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst <bgerst@didntduck.org> writes:

> Timmy Douglas wrote:
>> (I'm not subscribed so please CC me replies that you want me to reply
>> to.)
>> Recently I've found a problem with emacs where gcc optimizes a
>> function to be inline where it shouldn't be. The emacs developers use
>> a macro like this:
>>[snip]
>> I've realized that this file includes linux/compiler.h which does:
>>    139
>>    140  #ifndef noinline
>>    141  #define noinline
>>    142  #endif
>>    143
>>[snip]
>
> The right question to be asking is why is emacs including kernel headers?

I'm guessing it goes sort of like this:

signal.h -> bits/sigcontext.h -> asm/sigcontext.h -> linux/compiler.h

