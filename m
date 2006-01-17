Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWAQQz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWAQQz7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 11:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWAQQz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 11:55:58 -0500
Received: from mail.cs.umn.edu ([128.101.33.102]:40701 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id S932181AbWAQQz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 11:55:57 -0500
Date: Tue, 17 Jan 2006 10:55:55 -0600
From: Dave C Boutcher <sleddog@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       anton@au1.ibm.com, linux-kernel@vger.kernel.org, michael@ellerman.id.au,
       linuxppc64-dev@ozlabs.org, serue@us.ibm.com, paulus@au1.ibm.com
Subject: Re: 2.6.15-mm4 failure on power5
Message-ID: <20060117165555.GA24562@cs.umn.edu>
Reply-To: boutcher@cs.umn.edu
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@osdl.org>, anton@au1.ibm.com,
	linux-kernel@vger.kernel.org, michael@ellerman.id.au,
	linuxppc64-dev@ozlabs.org, serue@us.ibm.com, paulus@au1.ibm.com
References: <20060116063530.GB23399@sergelap.austin.ibm.com> <20060115230557.0f07a55c.akpm@osdl.org> <200601170000.58134.michael@ellerman.id.au> <20060116153748.GA25866@sergelap.austin.ibm.com> <20060116215252.GA10538@cs.umn.edu> <20060116170907.60149236.akpm@osdl.org> <20060117081749.GA10135@elte.hu> <20060117165244.GA23254@cs.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060117165244.GA23254@cs.umn.edu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2006 at 10:52:44AM -0600, Dave C Boutcher wrote:
> Well, it turns out that I've been running with CONFIG_DEBUG_MUTEXES all
> along...so no noise.  My console output is a little different that
> Serge's, so I think this is timing related.  Also note that I'm dying in
> the timer interrupt...

duh... here's the backtrace
0:mon> t
[c000000000577890] c0000000000034b4 decrementer_common+0xb4/0x100
--- Exception: 901 (Decrementer) at c0000000004627ec
.__mutex_lock_interruptible_slowpath+0x3bc/0x4c4
[c000000000577c60] c000000000075064 .__lock_cpu_hotplug+0x44/0xa8
[c000000000577ce0] c000000000075600 .register_cpu_notifier+0x24/0x68
[c000000000577d70] c00000000052cd7c .do_init_bootmem+0x68c/0xab0
[c000000000577e50] c000000000522c84 .setup_arch+0x21c/0x2c0
[c000000000577ef0] c00000000051a538 .start_kernel+0x40/0x280
[c000000000577f90] c000000000008574 .hmt_init+0x0/0x8c


-- 
Dave Boutcher
