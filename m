Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVFOSl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVFOSl6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 14:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVFOSl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 14:41:58 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:15248 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261265AbVFOSl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 14:41:56 -0400
Date: Wed, 15 Jun 2005 20:41:38 +0200
From: Pavel Machek <pavel@ucw.cz>
To: dagit@codersbase.com
Cc: Shaohua Li <shaohua.li@intel.com>, stefandoesinger@gmx.at,
       acpi-dev <acpi-devel@lists.sourceforge.net>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM (was: Re: [ACPI] Resume from Suspend to RAM))
Message-ID: <20050615184138.GA2308@elf.ucw.cz>
References: <1118125410.3828.12.camel@linux-hp.sh.intel.com> <87ll5diemh.fsf@www.codersbase.com> <20050614090652.GA1863@elf.ucw.cz> <87aclthr7l.fsf@www.codersbase.com> <20050614213728.GB2172@elf.ucw.cz> <87u0k061jx.fsf@www.codersbase.com> <20050614220911.GD2172@elf.ucw.cz> <87oea860rl.fsf@www.codersbase.com> <20050614231115.GE2172@elf.ucw.cz> <87ekb45u5a.fsf@www.codersbase.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ekb45u5a.fsf@www.codersbase.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> >> What should we try next?
> >> >
> >> > ??? You wanted it to reboot? If not, something is wrong with
> >> > stack. Not sure whats next.
> >> 
> >> I don't want it to reboot, I guess I got confused.  As you say, maybe
> >> something is wrong with the stack.  It's weird that something would be
> >> wrong with the stack, because the other test to check the
> >> suspend/resume code path works like a charm, the machine will do the
> >> fake suspend/resume just fine.
> >
> > Well, we set up stack few instructions before that. But we do it in
> > quite a complicated way; could you just put stack at 0x00:0x200 or
> > something like that? Also test if push alone is enough to kill it.
> 
> Could you send me the code you want me to test, I'd don't know enough
> asm to move the stack.  I tried replacing the line with the comment
> about the ASUS board private stack with a line like, "mov $0x200,
> %sp", but I don't understand it.

mov 0x200, %sp was good idea, but try to zero %ss, too. (xor %eax,
%eax; mov %eax, %ss).
								Pavel

-- 
teflon -- maybe it is a trademark, but it should not be.
