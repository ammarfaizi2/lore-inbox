Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263775AbUG1VIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUG1VIA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 17:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263847AbUG1VIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 17:08:00 -0400
Received: from digitalimplant.org ([64.62.235.95]:50322 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S263775AbUG1VHq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 17:07:46 -0400
Date: Wed, 28 Jul 2004 14:07:34 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Dave Hansen <haveblue@us.ibm.com>
cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] reduce swsusp casting
In-Reply-To: <1091043436.2871.320.camel@nighthawk>
Message-ID: <Pine.LNX.4.50.0407281405090.31994-100000@monsoon.he.net>
References: <1091043436.2871.320.camel@nighthawk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Jul 2004, Dave Hansen wrote:

> I noticed that swsusp uses quite a few interesting casts for __pa() and
> cousins.  This patch moves some types around to eliminate some of those
> casts in the normal code.  The casts that it adds are around alloc's and
> frees, which is a much more usual place to see them.
>
> Pavel also noticed that there's a superfluous PAGE_ALIGN() right before
> a >>PAGE_SHIFT in pfn_is_nosave(), so that's been removed as well.

What are these patches against? I released a bunch of patches to swsusp
and pmdisk two weeks ago. I'm not sure if Andrew has picked them up yet.
It would be nice if you would patch against those.

> I haven't had a chance to do anything but test it, because that would
> involve me setting up a swsusp rig, which I'm more prone to screw up
> than the patch itself :)  I'd appreciate if anyone with a stable setup
> could make sure I didn't do anything too stupid.

I don't understand - have you really tested it or just compile-tested it?
If not, please do try it out for real. There is no reason to be scared of
swsusp, and the more people that use it, the more stable it will get.

Thanks,


	Pat
