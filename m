Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWDZSYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWDZSYQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 14:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbWDZSYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 14:24:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:5781 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964795AbWDZSYP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 14:24:15 -0400
To: Martin Bligh <mbligh@google.com>
Cc: Ken Harrenstien <klh@google.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [kernel-reviewers] a small code review (2414483) Automated g4 rollback of changelist 2396062.
References: <444F0729.2020407@google.com> <444F0A94.70100@google.com>
	<6599ad830604252300m27db3d20j39beafbe09788824@mail.google.com>
	<444F1218.6020601@google.com>
	<6599ad830604252334yd6d933w5386dccb4af4b971@mail.google.com>
	<444F9777.9090704@google.com> <444F989B.3040900@google.com>
	<444F9E2B.40704@google.com> <444FA2BB.2070908@google.com>
	<Pine.LNX.4.56.0604261002430.4623@minbar.corp.google.com>
	<20060426173225.GB28519@google.com> <444FAFB6.4070303@google.com>
From: Andi Kleen <ak@suse.de>
Date: 26 Apr 2006 20:24:13 +0200
In-Reply-To: <444FAFB6.4070303@google.com>
Message-ID: <p731wvk8ab6.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh <mbligh@google.com> writes:

> Tim Hockin wrote:
> > On Wed, Apr 26, 2006 at 10:12:14AM -0700, Ken Harrenstien wrote:
> >
> >>That doesn't work because IIRC it only reports the amount of memory
> >>the kernel has been told (eg via "mem=") to manage in a certain sense,
> >>not how much is actually physically available.
> >>
> >>The I2 netboot kernel would really REALLY like some exported /proc
> >>values that accurately report physical memory (if nothing else, the
> >>number of DIMMs and their sizes).  It has to figure this out in order
> >>to install the proper kernel with proper LILO command-line args.
> > The kernel can't really know how much memory is in the system without
> > getting chipset-specific.
> > MTRR is a good way to hazard a guess, and will probably be right,
> > but as
> > you indicated, BIOS vendors have historically been REALLY bad about
> > MTRRs.  Better now, but bad a few years ago.
> > SMBIOS (on our boards) *does* accurately report the number of DIMMS
> > and
> > their sizes (and more!).  But it only works on Google BIOS.

Actually quite a lot of SMBIOS report DIMMs more or less correct.
It works even on my laptop.

I implemented support for it in the latest mcelog (--dmi). Not all
and a few big names screw it up (in particular the mappings from
address range to interleave set). But overall it looks surprisingly
good so far. 

-Andi
