Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265464AbTLHQbf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 11:31:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265480AbTLHQ3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 11:29:02 -0500
Received: from ns.int.pl ([212.106.140.230]:27657 "EHLO novacom.pl")
	by vger.kernel.org with ESMTP id S265464AbTLHQ0m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 11:26:42 -0500
Date: Mon, 8 Dec 2003 17:27:32 +0100
From: Rafal Skoczylas <nils@secprog.org>
To: linux-kernel@vger.kernel.org
Message-ID: <20031208162732.GC9087@secprog.org>
Reply-To: Rafal Skoczylas <nils@secprog.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312072100250.13236@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 07, 2003 at 09:17:35PM -0800, Linus Torvalds wrote:
> On Mon, 8 Dec 2003, Rafal Skoczylas wrote:
> > Unable to handle kernel paging request at virtual address 5a85fb5c
> > [...]
> > EIP:    0060:[remove_wait_queue+36/112]    Not tainted
> > [...]
> > eax: defb4000   ebx: da85fb58   ecx: 5a85fb58   edx: db0468b0
> > esi: db0468bc   edi: 00000292   ebp: defb5fa0   esp: defb5f58
> > Trace:
> >  [poll_freewait+36/80] poll_freewait+0x24/0x50
> >  [sys_poll+581/656] sys_poll+0x245/0x290
> >  [__pollwait+0/208] __pollwait+0x0/0xd0
> >  [syscall_call+7/11] syscall_call+0x7/0xb
> 
> It could be bad memory. We even know the address that is bad: it's
> (%esi+4), ie bit 31 of the word at physical address 0x1b0468f0.
> However, if you don't see random SIGSEGV's while compiling etc issues, it
> doesnt' sound like flaky RAM.

Indeed, I do not have any random SIGSEGVs at any time.
Additionaly, as what you said sounded right to me I performed extensive
memory tests with x86-memtest v3.0 during the night and as I expected
memory seems to be OK.

> Rafal - how consistent is the second form of the oops?
> Have you seen that trace more than once?

Not exactly the same, but there are some similarities (If I understand
this log correctly). I ripped those oopses out of the logs so maybe you
could look yourself and see something I don't see:
http://secprog.org/who/rs/linux/2.6-test11-log.txt
These are oopses I have experienced on test11 (Unfortunately, I dont have
logs from test9 since I don't keep logs that long on workstation).

nils.
-- 
"Blessed is the man, who having nothing to say, abstains from giving wordy
evidence of the fact."  -- http://secprog.org/who/rs/quote.php?id=1
