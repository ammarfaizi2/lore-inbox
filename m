Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbWCAKxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbWCAKxq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 05:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbWCAKxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 05:53:46 -0500
Received: from smtp.osdl.org ([65.172.181.4]:11496 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964900AbWCAKxp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 05:53:45 -0500
Date: Wed, 1 Mar 2006 02:52:19 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: port ATI timer fix from x86_64 to i386
Message-Id: <20060301025219.2034924c.akpm@osdl.org>
In-Reply-To: <p73psl6zbwf.fsf@verdi.suse.de>
References: <200602281905_MC3-1-B97E-7FDC@compuserve.com>
	<20060228161512.0cdbe560.akpm@osdl.org>
	<p73psl6zbwf.fsf@verdi.suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(Cc: fixed.  Please send me a copy of your MUA so I can ritually disembowel
it).

Andi Kleen <ak@suse.de> wrote:
>
> Andrew Morton <akpm@osdl.org> writes:
> 
> > Chuck Ebbert <76306.1226@compuserve.com> wrote:
> > >
> > >  This fixes the "timer runs too fast" bug on ATI chipsets (bugzilla #3927).
> > 
> > Wonderful, thanks.  What's the relationship (if any) between this and the
> > recently-merged x86_64 fix?
> 
> He just ported the x86-64 change over without any original authorship
> attribution :/

Yup.  And he proved that I am incapable of understanding a simple email
Subject:

> And some less functionality (only works for ACPI now) and some totally
> unrelated Documentation cleanup and a few random printk changes.
> 
> The ACPI only thing is probably mostly ok because the timing won't work
> at least on the dual cores without ACPI anyways because PMtimer is needed.
> On single cores it would be useful even without ACPI
> (for that earlyquirk.c just would need to be moved up to run independently
> of ACPI) 
> 
> Still it's probably a good idea for 2.6.16.
> 

Well..  the patch had a flagrant won't-compile if CONFIG_X86_IO_APIC=y, so
I'd consider it a bit green.

