Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVFNWJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVFNWJr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 18:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVFNWJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 18:09:47 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23521 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261371AbVFNWJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 18:09:45 -0400
Date: Wed, 15 Jun 2005 00:09:11 +0200
From: Pavel Machek <pavel@suse.cz>
To: dagit@codersbase.com
Cc: Shaohua Li <shaohua.li@intel.com>, stefandoesinger@gmx.at,
       acpi-dev <acpi-devel@lists.sourceforge.net>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM (was: Re: [ACPI] Resume from Suspend to RAM))
Message-ID: <20050614220911.GD2172@elf.ucw.cz>
References: <200506061531.41132.stefandoesinger@gmx.at> <1118125410.3828.12.camel@linux-hp.sh.intel.com> <87ll5diemh.fsf@www.codersbase.com> <20050614090652.GA1863@elf.ucw.cz> <87aclthr7l.fsf@www.codersbase.com> <20050614213728.GB2172@elf.ucw.cz> <87u0k061jx.fsf@www.codersbase.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87u0k061jx.fsf@www.codersbase.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> > You got this wrong. It is three illegal instructions but
> >> > *nested*. Like error, error in fault handler, error in doublefault
> >> > handler.
> >> 
> >> Ah.  Yeah, this isn't an area I know much about :)  Thanks for the
> >> correction. 
> >> 
> >> > Try replacing flags manipulation with any stack manipulation to see
> >> > what is wrong.
> >> 
> >> Do you mean try something like this? Replace the push 0 with push
> >> 0x1234 ; push 0x1234 ; pop ; pop and try to figure out which line
> >> causes the reboot?
> >
> > Yep, try pushl $0, popl %eax; if that causes problems, something is
> > seriously wrong with stack, otherwise changing flags hurts.
> 
> pushl $0, popl %eax gets the reboot.  So it's changing the flags that
> is bad?
> 
> What should we try next?

??? You wanted it to reboot? If not, something is wrong with
stack. Not sure whats next.

							Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
