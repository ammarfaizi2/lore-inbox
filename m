Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262123AbULCJKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbULCJKd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 04:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbULCJKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 04:10:33 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:46762 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262107AbULCJJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 04:09:15 -0500
Date: Fri, 3 Dec 2004 10:08:43 +0100
From: Andi Kleen <ak@suse.de>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, linux@rainbow-software.org,
       Dave Jones <davej@redhat.com>
Subject: Re: [PATCH] Cyrix MII cpuid returns stale %ecx
Message-ID: <20041203090843.GA25528@wotan.suse.de>
References: <Pine.LNX.4.61.0411302125350.1243@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0411302125350.1243@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2004 at 10:07:55PM -0700, Zwane Mwaikambo wrote:
> This patch is for the following bug, thanks to Ondrej Zary for 
> reporting, testing and submitting a patch.
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=3767
> 
> It appears that the Cyrix MII won't touch %ecx at all resulting in stale 
> data being returned as extended attributes, so clear ecx before issuing 
> the cpuid. I have also made the capability print code display all the 
> capability words for easier debugging in future.

Can you please change cpuid() on x86-64 too?

I think it would be also better to not printk the capabilities
at all or only with a special kernel option. Normally they are
not needed, but they clutter up the boot  log.

-Andi
