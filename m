Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVATTEJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVATTEJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 14:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVATTD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 14:03:58 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31683 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261711AbVATTBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 14:01:50 -0500
To: Werner Almesberger <wa@almesberger.net>
Cc: Andrew Morton <akpm@osdl.org>, fastboot@lists.osdl.org,
       <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Re: [PATCH 0/29] overview
References: <20050120102223.B14297@almesberger.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Jan 2005 12:00:08 -0700
In-Reply-To: <20050120102223.B14297@almesberger.net>
Message-ID: <m1vf9s3ozr.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger <wa@almesberger.net> writes:

> [ Re-sent - seems that one of my MTAs got confused and garbled most
>   of the addresses. ]
> 
> Eric W. Biederman wrote:
> > - This code needs to sit in a development tree for a little while 
> >   to shake out whatever bugs still linger from my massive refactoring.
> 
> I think there will be plenty of driver issues to address. However,
> pretty much all alternatives to kexec-based crash dumps (minus the
> firmware-based ones that reset everything but memory, of course)
> will suffer from the same problems - they may just be a little
> better at not noticing them.

Doubtless.  So far I only have 1 e1000 driver issue.  The IBM guys
were tracking an issue with one of the aic7xxx cards.  But those kinds
of issues seem to be fairly rare right now :) 
 
> > In the interests of full disclosure my main interesting is using the
> > kernel as a bootloader for other kernels
> 
> Me too :-) I'm a bit concerned that kexec has been hovering outside
> the mainline kernel for so long. This keeps the threshold for new
> work on the boot process high, delaying experiments and, ultimately,
> progress. 

To some extent.  It is worth noting that the first 13 of my patches
are not core functionality they are bug fixes or feature enhancements
of code that simply have come to be associated with the work on kexec.

Which is why I put them first in the list of things so it is clear
they don't depend on the core kexec code.  So some work in that
area seems to be happening and from what I have heard about ppc64
kexec support has been a motivating reason to clean up their boot
process some more.

The nice thing at this point I think one more cycle through the
development process and we should have a fairly well defined and
working mechanism for taking crash dumps.  With the remaining work
left simply to porting it.

Eric
