Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUH3WQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUH3WQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 18:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264502AbUH3WQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 18:16:29 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:9641 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S264443AbUH3WQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 18:16:27 -0400
Date: Mon, 30 Aug 2004 18:16:38 -0400
To: davem@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: TG3(Tigoon) & Kernel 2.4.27
Message-ID: <20040830221638.GA3596@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
From: neroden@fastmail.fm (Nathanael Nerode)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>The tg3 firmware is just a bunch of MIPS instructions.
Well, good to know that.  It's the first I'd heard of it.

>I guess if I ran objdump --disassemble on the image and
>used the output of that in the tg3 driver and "compiled
>that source" they'd be happy.  And this makes the situation
>even more ludicrious.

Before you blithely made this claim, you should have actually tried running
objdump --disassemble on the image.

It's not packed up in a standard ELF/COFF/etc format, so that doesn't
actually work.  You can use simple assembler trickery to pack it up into a
normal object file *if* you have an assembler for mips *and* you know whether
the chip is running little-endian or big-endian (I have no idea). You may
need other information as well.  :-P  Then and only then can you try to
dissassemble it with objdump.  Then you have to separate data in the text
section out from the code in order to get something which actually
approximates source code.

Much simpler for Broadcom to just release the source code.  :-P

-- 
This space intentionally left blank.
