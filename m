Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbUBUTie (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 14:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbUBUTie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 14:38:34 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1158 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261609AbUBUTid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 14:38:33 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Machek <pavel@suse.cz>, Stephen Hemminger <shemminger@osdl.org>,
       ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: kernel/microcode.c error from new 64bit code
References: <20040218145218.6bae77b5@dell_ss3.pdx.osdl.net>
	<Pine.LNX.4.58.0402181502260.18038@home.osdl.org>
	<20040221141608.GB310@elf.ucw.cz>
	<Pine.LNX.4.58.0402210914530.3301@ppc970.osdl.org>
	<20040221173449.GA277@elf.ucw.cz>
	<Pine.LNX.4.58.0402210944050.3301@ppc970.osdl.org>
	<m18yiwl1pd.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.58.0402211102360.3301@ppc970.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Feb 2004 12:30:34 -0700
In-Reply-To: <Pine.LNX.4.58.0402211102360.3301@ppc970.osdl.org>
Message-ID: <m14qtkkz6t.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 21 Feb 2004, Eric W. Biederman wrote:
> > 
> > What is wrong with the original?
> > 
> > -       wrmsr(MSR_IA32_UCODE_WRITE, (unsigned int)(uci->mc->bits), 0);
> > 
> > I don't see how anything else could be correct.
> 
> Did you miss the fact that we now support x86-64, and that if compiled 
> that way the address is 64-bit?

No I missed the fact that uci->mc->bits was an address.  Now it
makes sense how we can have a 64bit value only in 64bit mode....

The code still feels a little awkward but after looking at it
some more I don't see any problems.

Eric
