Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268846AbUHLW2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268846AbUHLW2b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 18:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268837AbUHLW2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 18:28:31 -0400
Received: from mail.tpgi.com.au ([203.12.160.61]:16364 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S268846AbUHLW0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 18:26:44 -0400
Subject: Re: suspend2 with smp
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040812215644.GA20021@elf.ucw.cz>
References: <20040812215644.GA20021@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1092349414.24776.16.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 13 Aug 2004 08:23:35 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-08-13 at 07:56, Pavel Machek wrote:
> Hi!
> 
> At some point I claimed that SMP support in suspend2 is "probably
> broken". I guess I should post more data:
> 
> It is broken in theory.
> 
> CPU is basically looping in loop marked by #, while its memory is
> being overwriten. Now, the code probably works in practice, but it
> should be really written in assembly so that compiler can not do
> something stupid.
> 
> Compilers are not designed to deal with their stack (etc) randomly
> overwritten, so compiler may do anything it wants here. I see that -O0
> may help a lot here, but it simply is not the right thing to do.
> 
> At least /* FIXME: should be rewritten to assembly */ should be added there.

Ah, okay. So it's not that the code itself broken, but that you don't
trust the assembler to do the right thing with the code. I'll happily
include an inline asm routine if you'll code it for me (I don't know x86
assembly). In case I haven't said it already, feel free to take the
freezer changes and put them in your code. I'd only be submitting a
patch to do the same anyway.

Nigel
-- 
Nigel Cunningham
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. But true tolerance can cope with others
being intolerant.

