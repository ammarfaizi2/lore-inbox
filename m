Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUBUS6H (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 13:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbUBUS6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 13:58:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:37026 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261603AbUBUS6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 13:58:05 -0500
Date: Sat, 21 Feb 2004 11:03:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Pavel Machek <pavel@suse.cz>, Stephen Hemminger <shemminger@osdl.org>,
       ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: kernel/microcode.c error from new 64bit code
In-Reply-To: <m18yiwl1pd.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.58.0402211102360.3301@ppc970.osdl.org>
References: <20040218145218.6bae77b5@dell_ss3.pdx.osdl.net>
 <Pine.LNX.4.58.0402181502260.18038@home.osdl.org> <20040221141608.GB310@elf.ucw.cz>
 <Pine.LNX.4.58.0402210914530.3301@ppc970.osdl.org> <20040221173449.GA277@elf.ucw.cz>
 <Pine.LNX.4.58.0402210944050.3301@ppc970.osdl.org> <m18yiwl1pd.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 21 Feb 2004, Eric W. Biederman wrote:
> 
> What is wrong with the original?
> 
> -       wrmsr(MSR_IA32_UCODE_WRITE, (unsigned int)(uci->mc->bits), 0);
> 
> I don't see how anything else could be correct.

Did you miss the fact that we now support x86-64, and that if compiled 
that way the address is 64-bit?

		Linus
