Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVFNVhv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVFNVhv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 17:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVFNVhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 17:37:51 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:1925 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261350AbVFNVhp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 17:37:45 -0400
Date: Tue, 14 Jun 2005 23:37:28 +0200
From: Pavel Machek <pavel@suse.cz>
To: dagit@codersbase.com
Cc: Shaohua Li <shaohua.li@intel.com>, stefandoesinger@gmx.at,
       acpi-dev <acpi-devel@lists.sourceforge.net>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM (was: Re: [ACPI] Resume from Suspend to RAM))
Message-ID: <20050614213728.GB2172@elf.ucw.cz>
References: <200506061531.41132.stefandoesinger@gmx.at> <1118125410.3828.12.camel@linux-hp.sh.intel.com> <87ll5diemh.fsf@www.codersbase.com> <20050614090652.GA1863@elf.ucw.cz> <87aclthr7l.fsf@www.codersbase.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87aclthr7l.fsf@www.codersbase.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > You got this wrong. It is three illegal instructions but
> > *nested*. Like error, error in fault handler, error in doublefault
> > handler.
> 
> Ah.  Yeah, this isn't an area I know much about :)  Thanks for the
> correction. 
> 
> > Try replacing flags manipulation with any stack manipulation to see
> > what is wrong.
> 
> Do you mean try something like this? Replace the push 0 with push
> 0x1234 ; push 0x1234 ; pop ; pop and try to figure out which line
> causes the reboot?

Yep, try pushl $0, popl %eax; if that causes problems, something is
seriously wrong with stack, otherwise changing flags hurts.

> > Like perhaps processor docs?
> 
> Is that what I want to look at?  I was the one asking the question. ;)

Yes.
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
