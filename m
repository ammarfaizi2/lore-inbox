Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262365AbULCQ7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262365AbULCQ7z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 11:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbULCQ7z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 11:59:55 -0500
Received: from zeus.kernel.org ([204.152.189.113]:59299 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262365AbULCQ7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 11:59:52 -0500
Date: Fri, 3 Dec 2004 09:57:00 -0700 (MST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       linux@rainbow-software.org, Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] Cyrix MII cpuid returns stale %ecx
In-Reply-To: <20041203090843.GA25528@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0412030955510.18003@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0411302125350.1243@montezuma.fsmlabs.com>
 <20041203090843.GA25528@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Dec 2004, Andi Kleen wrote:

> On Tue, Nov 30, 2004 at 10:07:55PM -0700, Zwane Mwaikambo wrote:
> > This patch is for the following bug, thanks to Ondrej Zary for 
> > reporting, testing and submitting a patch.
> > 
> > http://bugzilla.kernel.org/show_bug.cgi?id=3767
> > 
> > It appears that the Cyrix MII won't touch %ecx at all resulting in stale 
> > data being returned as extended attributes, so clear ecx before issuing 
> > the cpuid. I have also made the capability print code display all the 
> > capability words for easier debugging in future.
> 
> Can you please change cpuid() on x86-64 too?
> 
> I think it would be also better to not printk the capabilities
> at all or only with a special kernel option. Normally they are
> not needed, but they clutter up the boot  log.

Isn't the KERN_DEBUG prefix sufficient?

Thanks,
	Zwane

