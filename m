Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965919AbWKXTLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965919AbWKXTLf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 14:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935015AbWKXTLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 14:11:34 -0500
Received: from mail.suse.de ([195.135.220.2]:469 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S935014AbWKXTLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 14:11:34 -0500
From: Andi Kleen <ak@suse.de>
To: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] x86_64 vsyscall fails to compile when CONFIG_HOTPLUG_CPU is disabled
Date: Fri, 24 Nov 2006 20:11:27 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20061123021703.8550e37e.akpm@osdl.org> <e605df1da2b2e35ab69e8167c2b71b7f@pinky>
In-Reply-To: <e605df1da2b2e35ab69e8167c2b71b7f@pinky>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611242011.27917.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 November 2006 18:58, Andy Whitcroft wrote:
> x86_64 vsyscall fails to compile when CONFIG_HOTPLUG_CPU is disabled
> 
> The following change attempted to fix up the notifier structure
> when CONFIG_HOTPLUG_CPU is disabled:
> 
>     [PATCH] x86-64: Fix vgetcpu when CONFIG_HOTPLUG_CPU is disabled
> 
> It seems to leave a reference to the cpu_vsyscall_notifier which is
> not declared unles CONFIG_HOTPLUG_CPU is defined, leading to the following
> compile time error:

It's ok in mainline,  unfortunately mm has another independent patch that 
broke it again.

-Andi
