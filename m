Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVFNWBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVFNWBO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 18:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVFNWBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 18:01:14 -0400
Received: from smtp-auth.no-ip.com ([8.4.112.95]:15041 "HELO
	smtp-auth.no-ip.com") by vger.kernel.org with SMTP id S261369AbVFNWBK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 18:01:10 -0400
From: dagit@codersbase.com
To: Pavel Machek <pavel@suse.cz>
Cc: Shaohua Li <shaohua.li@intel.com>, stefandoesinger@gmx.at,
       acpi-dev <acpi-devel@lists.sourceforge.net>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: S3 test tool (was : Re: Bizarre oops after suspend to RAM (was:
 Re: [ACPI] Resume from Suspend to RAM))
References: <200506061531.41132.stefandoesinger@gmx.at>
	<1118125410.3828.12.camel@linux-hp.sh.intel.com>
	<87ll5diemh.fsf@www.codersbase.com> <20050614090652.GA1863@elf.ucw.cz>
	<87aclthr7l.fsf@www.codersbase.com> <20050614213728.GB2172@elf.ucw.cz>
Organization: Coders' Base
Date: Tue, 14 Jun 2005 15:01:06 -0700
In-Reply-To: <20050614213728.GB2172@elf.ucw.cz> (Pavel Machek's message of
 "Tue, 14 Jun 2005 23:37:28 +0200")
Message-ID: <87u0k061jx.fsf@www.codersbase.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-REPORT-SPAM-TO: abuse@no-ip.com
X-NO-IP: codersbase.com@noip-smtp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> writes:

> Hi!
>
>> > You got this wrong. It is three illegal instructions but
>> > *nested*. Like error, error in fault handler, error in doublefault
>> > handler.
>> 
>> Ah.  Yeah, this isn't an area I know much about :)  Thanks for the
>> correction. 
>> 
>> > Try replacing flags manipulation with any stack manipulation to see
>> > what is wrong.
>> 
>> Do you mean try something like this? Replace the push 0 with push
>> 0x1234 ; push 0x1234 ; pop ; pop and try to figure out which line
>> causes the reboot?
>
> Yep, try pushl $0, popl %eax; if that causes problems, something is
> seriously wrong with stack, otherwise changing flags hurts.

pushl $0, popl %eax gets the reboot.  So it's changing the flags that
is bad?

What should we try next?

thanks,
Jason


