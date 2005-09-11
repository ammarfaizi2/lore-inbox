Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbVIKHyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbVIKHyJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 03:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964819AbVIKHyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 03:54:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61607 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964817AbVIKHyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 03:54:08 -0400
Date: Sun, 11 Sep 2005 00:53:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Frank van Maarseveen <frankvm@frankvm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13: Badness in send_IPI_mask_bitmask at
 arch/i386/kernel/smp.c:168
Message-Id: <20050911005339.4a2452b7.akpm@osdl.org>
In-Reply-To: <20050910140532.GA32331@janus>
References: <20050910140532.GA32331@janus>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank van Maarseveen <frankvm@frankvm.com> wrote:
>
> Badness in send_IPI_mask_bitmask at arch/i386/kernel/smp.c:168
> 
> See www.frankvm.com/tmp/badness-smp-168.jpg for the full trace
> 
> This _might_ have some relationship with the time anomalies seen on this machine.
> 
> Hardware: AMD Athlon X2 (SMP, i386). 
> 

I assume that was in response to a `halt -p'?

Either you don't have a pm_power_off handler, or the one which you do have
is returning to the caller rather than powering off.

Did the machine correctly power itself off under any earlier kernel?  If
so, which version?

Please send the full boot-time dmesg output from the failing kernel.
