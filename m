Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132041AbRAIWpO>; Tue, 9 Jan 2001 17:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130018AbRAIWoz>; Tue, 9 Jan 2001 17:44:55 -0500
Received: from jump-isi.interactivesi.com ([207.8.4.2]:57588 "HELO
	dinero.interactivesi.com") by vger.kernel.org with SMTP
	id <S129835AbRAIWov>; Tue, 9 Jan 2001 17:44:51 -0500
Date: Tue, 9 Jan 2001 16:44:50 -0600
From: Timur Tabi <ttabi@interactivesi.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <01010923324500.02850@rob>
In-Reply-To: <01010922090000.02630@rob> <01010922264400.02737@rob> <3A5B86C1.41DDB11B@didntduck.org> 
	<3A5B86C1.41DDB11B@didntduck.org>
Subject: Re: Anybody got 2.4.0 running on a 386 ?
X-Mailer: The Polarbar Mailer; version=1.19a; build=73
Message-Id: <20010109224454Z129835-400+2448@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

** Reply to message from Robert Kaiser <rob@sysgo.de> on Tue, 9 Jan 2001
23:17:11 +0100


> temp = mk_pte_phys(__pa(vaddr), PAGE_KERNEL);
> 	*pte = temp;
> 
> where temp is declared "volatile pte_t". I inserted test-prints between the
> above two lines. Accoding to that, the _first_ line , i.e. the evaluation of the
> mk_pte_phys() macro is causing the crash!

In that case, it's either a compiler bug or a race condition.

Compiling this source file with the -S option will generate an assembly output.
The output should be the same regardless of whether you use the temp variable or
not.  That will answer the question as to what the cause is.  If you're lucky,
it's a compiler bug, because they're easier to fix.


-- 
Timur Tabi - ttabi@interactivesi.com
Interactive Silicon - http://www.interactivesi.com

When replying to a mailing-list message, please direct the reply to the mailing list only.  Don't send another copy to me.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
