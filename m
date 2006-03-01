Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbWCAKkG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbWCAKkG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 05:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbWCAKkG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 05:40:06 -0500
Received: from cantor2.suse.de ([195.135.220.15]:9125 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964910AbWCAKkF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 05:40:05 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] i386: port ATI timer fix from x86_64 to i386
References: <200602281905_MC3-1-B97E-7FDC@compuserve.com>
	<20060228161512.0cdbe560.akpm@osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 01 Mar 2006 11:40:00 +0100
In-Reply-To: <20060228161512.0cdbe560.akpm@osdl.org>
Message-ID: <p73psl6zbwf.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Chuck Ebbert <76306.1226@compuserve.com> wrote:
> >
> >  This fixes the "timer runs too fast" bug on ATI chipsets (bugzilla #3927).
> 
> Wonderful, thanks.  What's the relationship (if any) between this and the
> recently-merged x86_64 fix?

He just ported the x86-64 change over without any original authorship
attribution :/

And some less functionality (only works for ACPI now) and some totally
unrelated Documentation cleanup and a few random printk changes.

The ACPI only thing is probably mostly ok because the timing won't work
at least on the dual cores without ACPI anyways because PMtimer is needed.
On single cores it would be useful even without ACPI
(for that earlyquirk.c just would need to be moved up to run independently
of ACPI) 

Still it's probably a good idea for 2.6.16.

-Andi
 
