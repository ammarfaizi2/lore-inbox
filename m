Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274992AbTHQCEP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 22:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274996AbTHQCEP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 22:04:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:57520 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S274992AbTHQCEO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 22:04:14 -0400
Message-ID: <33247.4.4.25.4.1061085853.squirrel@www.osdl.org>
Date: Sat, 16 Aug 2003 19:04:13 -0700 (PDT)
Subject: Re: 2.6-test2: gcc-3.3.1 warning.
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0308161830110.25379-100000@home.osdl.org>
References: <20030817012551.GB22022@twiddle.net>
        <Pine.LNX.4.44.0308161830110.25379-100000@home.osdl.org>
X-Priority: 3
Importance: Normal
Cc: <rth@twiddle.net>, <lcapitulino@prefeitura.sp.gov.br>,
       <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On Sat, 16 Aug 2003, Richard Henderson wrote:
>>
>> Fixed by doing
>>
>> 	__asm__ __volatile__("lidt %0": :"m" (*no_idt));
>
> Good catch, although I'd prefer something like this instead (ie change
> "no_idt" to be a real IDT descriptor, like the other ones).
>
> It shouldn't matter all that much, since the only thing that really  matters
> is to load the IDT with bogus values, so just about anything  should do it.

Yep, I have had some private email about this and had this patch
queued for this weekend.  Same as yours, use the struct for it.

~Randy



