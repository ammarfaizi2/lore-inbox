Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbUKCLR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbUKCLR1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 06:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261554AbUKCLR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 06:17:27 -0500
Received: from cantor.suse.de ([195.135.220.2]:42692 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261549AbUKCLRY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 06:17:24 -0500
Date: Wed, 3 Nov 2004 12:05:11 +0100
From: Andi Kleen <ak@suse.de>
To: Daniel Egger <degger@fhm.edu>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.8 and 2.6.9 Dual Opteron glitches
Message-ID: <20041103110511.GA23808@wotan.suse.de>
References: <5AC1EEB8-2CD7-11D9-BF00-000A958E35DC@fhm.edu.suse.lists.linux.kernel> <p737jp38qs4.fsf@verdi.suse.de> <8A4609E0-2D86-11D9-BF00-000A958E35DC@fhm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8A4609E0-2D86-11D9-BF00-000A958E35DC@fhm.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03, 2004 at 11:53:05AM +0100, Daniel Egger wrote:
> On 03.11.2004, at 06:06, Andi Kleen wrote:
> 
> >>   Replacing those panic(s) by printk make the machine boot just fine
> >>   and also work (seemingly) without any problems under load.
> 
> >Can you print the two values? I've never seen such a problem.
> >If it works then they must be identical, otherwise user space would
> >break very quickly.
> 
> printk("%p %p %p\n", (unsigned long) &vgettimeofday, &vgettimeofday, 
> VSYSCALL_ADDR(__NR_vgettimeofday));
> 
> ffffffffff600000 ffffffffff600000 ffffffffff600000
> 
> I've no idea why it still triggers. Also the next one BTW:
> vtime link addr brokenIA32
> 
> The compiler is: gcc version 3.4.0 20040111 (experimental)

Looks like a compiler bug. I would talk to the gcc people.

-Andi
