Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbTJaPY6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 10:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbTJaPY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 10:24:58 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13576 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263357AbTJaPY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 10:24:56 -0500
Date: Fri, 31 Oct 2003 15:24:53 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Ian Soboroff <ian.soboroff@nist.gov>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Post-halloween doc updates.
Message-ID: <20031031152453.F4556@flint.arm.linux.org.uk>
Mail-Followup-To: Ian Soboroff <ian.soboroff@nist.gov>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20031030141519.GA10700@redhat.com> <9cfd6cdla4o.fsf@rogue.ncsl.nist.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <9cfd6cdla4o.fsf@rogue.ncsl.nist.gov>; from ian.soboroff@nist.gov on Fri, Oct 31, 2003 at 10:06:31AM -0500
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 31, 2003 at 10:06:31AM -0500, Ian Soboroff wrote:
> And APM suspend seems to have broken in -test8.  Does it work for
> anyone?

Doesn't work for me.

Now, taking off my "open source co-operative hat" and placing my
"reality" hat on, I'd suggest that anyone who finds that APM doesn't
work to consider it a dead loss - It's an obsolete technology, and
therefore no one is interested in it anymore.  I've reported the
problem multiple times here and there's been very little, if any,
reaction, so this seems to back that up.

Now, imagine the PCMCIA maintainer being unable to test the suspend/
resume functionality during the stability freeze.  Oh, sorry, you
don't have to imagine that hard. 8)

> Dave Jones <davej@redhat.com> writes:
> 
> > Power management.
> > ~~~~~~~~~~~~~~~~~
> > - 2.6 contains a more up to date snapshot of the ACPI driver. Should
> >   you experience any problems booting, try booting with the argument
> >   "acpi=off" to rule out any ACPI interaction. ACPI has a much more involved
> >   role in bringing the system up in 2.6 than it did in 2.4
> > - The old "acpismp=force" boot option is now obsolete, and will be ignored
> >   due to the old "mini ACPI" parser being removed.
> > - software suspend is still in development, and in need of more work.
> >   Use with SMP and/or PREEMPT not advised.
> > - The ACPI code will do basic sanity checks on the DMI structure in the BIOS
> >   to determine the date it was written. BIOSes older than year 2000 are
> >   assumed to be broken. In some circumstances, this assumption is wrong.
> >   If you see a message saying ACPI is disabled for this reason, try booting
> >   with acpi=force. If things work fine, send the output of dmidecode
> >   (http://www.nongnu.org/dmidecode/) to acpi-devel@lists.sf.net
> >   with an explanation of why your BIOS shouldn't be blacklisted.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
