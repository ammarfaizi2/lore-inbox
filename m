Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbUGMCk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUGMCk6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 22:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262370AbUGMCk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 22:40:58 -0400
Received: from holomorphy.com ([207.189.100.168]:36242 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262356AbUGMCk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 22:40:56 -0400
Date: Mon, 12 Jul 2004 19:40:51 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Gabriel Devenyi <devenyga@mcmaster.ca>
Cc: ck@vds.kolivas.org, linux-kernel@vger.kernel.org
Subject: Re: Preempt Threshold Measurements
Message-ID: <20040713024051.GQ21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Gabriel Devenyi <devenyga@mcmaster.ca>, ck@vds.kolivas.org,
	linux-kernel@vger.kernel.org
References: <200407121943.25196.devenyga@mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407121943.25196.devenyga@mcmaster.ca>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 12, 2004 at 07:43:25PM -0400, Gabriel Devenyi wrote:
> Keeping in mind that I'm using the nvidia-kernel drivers, here are my preempt 
> threshold violations.
> 6ms non-preemptible critical section violated 4 ms preempt threshold starting 
> at kernel_fpu_begin+0xd/0x50 and ending at _mmx_memcpy+0x127/0x170
>  [<c0241987>] _mmx_memcpy+0x127/0x170
>  [<c01163b0>] dec_preempt_count+0x110/0x120
>  [<c0241987>] _mmx_memcpy+0x127/0x170
>  [<c012d3b5>] load_module+0x835/0x900
>  [<c013c84e>] unmap_vmas+0x10e/0x1f0
>  [<c012d4fb>] sys_init_module+0x7b/0x230
>  [<c0103ee1>] sysenter_past_esp+0x52/0x71

Things tend to be slow and stupid in the interest of robustness during
system initialization.

I'd suggest ignoring those unless you're specifically interested in boot
time (in which case you should be doing things for yourself) and focusing
on ones reported during normal usage after the system is up.


-- wli
