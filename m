Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbTJaQOz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 11:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbTJaQOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 11:14:55 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:42760 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263388AbTJaQOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 11:14:54 -0500
Date: Fri, 31 Oct 2003 16:14:50 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ian Soboroff <ian.soboroff@nist.gov>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Post-halloween doc updates.
Message-ID: <20031031161450.G4556@flint.arm.linux.org.uk>
Mail-Followup-To: Ian Soboroff <ian.soboroff@nist.gov>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20031030141519.GA10700@redhat.com> <9cfd6cdla4o.fsf@rogue.ncsl.nist.gov> <20031031152453.F4556@flint.arm.linux.org.uk> <9cfn0bhjswn.fsf@rogue.ncsl.nist.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <9cfn0bhjswn.fsf@rogue.ncsl.nist.gov>; from ian.soboroff@nist.gov on Fri, Oct 31, 2003 at 11:03:52AM -0500
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 31, 2003 at 11:03:52AM -0500, Ian Soboroff wrote:
> Well, ok, but the alternatives are ACPI, which has always been spotty,

Wrong - there are systems out there which do not support ACPI (or maybe
the kernel doesn't support the ACPI which is implemented in them.)

> and two competing power management schemes from Patrick and Pavel,
> neither of which seem to actually work yet.  Wouldn't it be nice to
> have at least one working method of putting a laptop to sleep?

Indeed.  With 2.6 there are zero ways I can make my x86 laptop
suspend or hibernate.

> Once I get some free time (maybe next week, who knows) I'll try
> backing out bits of the -test8 patch to see what broke.  In the
> meantime, -test7 works great.

Oh, my problem goes back many kernel versions.  It's nothing new.
Somewhere during 2.5 development (current thinking is somewhere
around 2.5.3x) something changed which makes the APM BIOS believe
that the machine isn't in the correct state to suspend.

However, exactly what that is seems to be impossible to track down.
Building a kernel minimal driver support results in a system which
can't suspend... and by "minimal" that includes dropping stuff like
the input layer and console completely from the kernel.

It basically comes down to some really subtle change in what 2.6 is
does differently from 2.4.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
