Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWFFNpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWFFNpJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 09:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWFFNpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 09:45:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:12753 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932160AbWFFNpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 09:45:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=o00RmFCPGVne2PjaSDC6JvibphAaq/mtpWLLw+SJqvCHW4R8FOoMDUQu2QWT4LxGg4qYlPghtYpHXZZ3TGBXvvIBgHBN9m1akv131Stp4yYFlHV/WCWwxqzaUhBnDhYtZJ0B9CxwEWrI2QjBLYl+7Wmc/0szzuCckyX1gw2I1zk=
Message-ID: <448586EC.301@gmail.com>
Date: Tue, 06 Jun 2006 15:44:53 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Andrew Morton <akpm@osdl.org>, arjan@infradead.org, mingo@redhat.com,
       linux-kernel@vger.kernel.org, stefanr@s5r6.in-berlin.de
Subject: Re: 2.6.17-rc5-mm3-lockdep -
References: <200606060250.k562oCrA004583@turing-police.cc.vt.edu>            <44852819.2080503@gmail.com> <200606061301.k56D12mH004130@turing-police.cc.vt.edu>
In-Reply-To: <200606061301.k56D12mH004130@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu napsal(a):
> On Tue, 06 Jun 2006 09:00:18 +0159, Jiri Slaby said:
>> Valdis.Kletnieks@vt.edu napsal(a):
>>> It's living longer before it throws a complaint - we're making it out of
>>> rc.sysinit and into rc5.d ;)  This time we were in an 'id' command from this:
>>>
>>> test `id -u` = 0  || exit 4
> 
>>> [  464.687000] illegal {in-hardirq-W} -> {hardirq-on-W} usage.
>>> [  464.687000] id/2700 [HC0[0]:SC0[1]:HE1:SE0] takes:
>>> [  464.687000]  (&list->lock){++..}, at: [<c0351a07>] unix_stream_connect+0x334/0x408
>>> [  464.687000] {in-hardirq-W} state was registered at:
>>> [  464.687000]   [<c012dd45>] lockdep_acquire+0x67/0x7f
>>> [  464.687000]   [<c0383f11>] _spin_lock_irqsave+0x30/0x3f
>>> [  464.687000]   [<c02fa93f>] skb_dequeue+0x18/0x49
>>> [  464.687000]   [<f086b7f1>] hpsb_bus_reset+0x5e/0xa2 [ieee1394]
>>> [  464.687000]   [<f0887007>] ohci_irq_handler+0x370/0x726 [ohci1394]
>>> [  464.687000]   [<c013f9a8>] handle_IRQ_event+0x1d/0x52
>>> [  464.687000]   [<c0140bc4>] handle_level_irq+0x97/0xe3
>>> [  464.687000]   [<c01045d0>] do_IRQ+0x8b/0xaf
>>> [  464.687000] irq event stamp: 2964
> 
>> That one would be corrected now:
>> http://lkml.org/lkml/2006/6/5/100
> 
> I'd agree, except I had already hit *that* one and applied Stefan's patches...
Ok, stand corrected. Sorry for the noise.

thanks,
-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
