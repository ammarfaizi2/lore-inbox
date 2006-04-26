Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964773AbWDZRoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964773AbWDZRoS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 13:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964772AbWDZRoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 13:44:18 -0400
Received: from smtp-out.google.com ([216.239.33.17]:49238 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S932326AbWDZRoR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 13:44:17 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:to:cc:subject:message-id:references:
	mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
	b=ZtDWlx4B0kAsOBvlieQ77jVu59JzKZgBiUH6fO6LnmPWdtNVMdK+w5cyTElC6tg7S
	VSkl6gb5P/315e2QHoBTw==
Date: Wed, 26 Apr 2006 10:43:52 -0700
From: Tim Hockin <thockin@google.com>
To: Martin Bligh <mbligh@google.com>
Cc: Ken Harrenstien <klh@google.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [kernel-reviewers] a small code review (2414483) Automated g4 rollback of changelist 2396062.
Message-ID: <20060426174352.GC28519@google.com>
References: <6599ad830604252300m27db3d20j39beafbe09788824@mail.google.com> <444F1218.6020601@google.com> <6599ad830604252334yd6d933w5386dccb4af4b971@mail.google.com> <444F9777.9090704@google.com> <444F989B.3040900@google.com> <444F9E2B.40704@google.com> <444FA2BB.2070908@google.com> <Pine.LNX.4.56.0604261002430.4623@minbar.corp.google.com> <20060426173225.GB28519@google.com> <444FAFB6.4070303@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444FAFB6.4070303@google.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 10:36:54AM -0700, Martin Bligh wrote:
> Tim Hockin wrote:
> >On Wed, Apr 26, 2006 at 10:12:14AM -0700, Ken Harrenstien wrote:
> >
> >>That doesn't work because IIRC it only reports the amount of memory
> >>the kernel has been told (eg via "mem=") to manage in a certain sense,
> >>not how much is actually physically available.
> >>
> >>The I2 netboot kernel would really REALLY like some exported /proc
> >>values that accurately report physical memory (if nothing else, the
> >>number of DIMMs and their sizes).  It has to figure this out in order
> >>to install the proper kernel with proper LILO command-line args.
> >
> >
> >The kernel can't really know how much memory is in the system without
> >getting chipset-specific.
> >
> >MTRR is a good way to hazard a guess, and will probably be right, but as
> >you indicated, BIOS vendors have historically been REALLY bad about
> >MTRRs.  Better now, but bad a few years ago.
> >
> >SMBIOS (on our boards) *does* accurately report the number of DIMMS and
> >their sizes (and more!).  But it only works on Google BIOS.
> 
> Are you saying our e820 maps and srat tables are wrong? that's a little
> worrying ...

e820 is fine, except there's not a good kernel interface to it.  Parsing
dmesg is *always* a last resort.

We don;t currently have SRAT. :)

