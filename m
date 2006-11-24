Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965823AbWKXSER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965823AbWKXSER (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Nov 2006 13:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935001AbWKXSER
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Nov 2006 13:04:17 -0500
Received: from twin.jikos.cz ([213.151.79.26]:51919 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S935000AbWKXSER (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Nov 2006 13:04:17 -0500
Date: Fri, 24 Nov 2006 19:03:59 +0100 (CET)
From: Jiri Kosina <jikos@jikos.cz>
To: Andy Whitcroft <apw@shadowen.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64 vsyscall fails to compile when CONFIG_HOTPLUG_CPU
 is disabled
In-Reply-To: <e605df1da2b2e35ab69e8167c2b71b7f@pinky>
Message-ID: <Pine.LNX.4.64.0611241903080.8989@twin.jikos.cz>
References: <20061123021703.8550e37e.akpm@osdl.org> <e605df1da2b2e35ab69e8167c2b71b7f@pinky>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Nov 2006, Andy Whitcroft wrote:

> The following change attempted to fix up the notifier structure
> when CONFIG_HOTPLUG_CPU is disabled:
> It seems to leave a reference to the cpu_vsyscall_notifier which is
> not declared unles CONFIG_HOTPLUG_CPU is defined, leading to the following
> compile time error:
>   arch/x86_64/kernel/vsyscall.c:310: error: `cpu_vsyscall_notifier'
> 				  undeclared (first use in this function)
> Make the hotcpu_notifier dependant on CONFIG_HOTPLUG_CPU.

Another fix is appropriate for -mm, please see this thread: 
http://lkml.org/lkml/2006/11/23/121

-- 
Jiri Kosina
