Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264027AbTKDJef (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 04:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264028AbTKDJef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 04:34:35 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:8576
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264027AbTKDJee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 04:34:34 -0500
Date: Tue, 4 Nov 2003 04:33:59 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6] Dont use cpu_has_pse for WP test branch
In-Reply-To: <Pine.LNX.4.53.0311040155150.20595@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.53.0311040431140.20595@montezuma.fsmlabs.com>
References: <Pine.LNX.4.53.0311040155150.20595@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Nov 2003, Zwane Mwaikambo wrote:

> It appears that not all processors which support PSE have the PSE bit set, 
> possibly we should be checking with PSE36 too. But instead i've opted to 
> simply check for 586+
> 
> Celeron (Mendocino): fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca 
> cmov pat pse36 mmx fxsr
> 
> Opteron 240: fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat 
> pse36 clflush mmx fxsr sse sse2 syscall mmxext lm 3dnowext 3dnow

Please ignore this patch, turns out CONFIG_DEBUG_PAGEALLOC disables the 
PSE bit in early_cpu_init.

