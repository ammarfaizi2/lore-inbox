Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265530AbUFCP6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265530AbUFCP6U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 11:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265428AbUFCPzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 11:55:22 -0400
Received: from cantor.suse.de ([195.135.220.2]:28389 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264962AbUFCPy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 11:54:27 -0400
Date: Thu, 3 Jun 2004 17:54:22 +0200
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       arjanv@redhat.com, suresh.b.siddha@intel.com, jun.nakajima@intel.com
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,
 2.6.7-rc2-bk2
Message-Id: <20040603175422.4378d901.ak@suse.de>
In-Reply-To: <20040603124448.GA28775@elte.hu>
References: <20040602205025.GA21555@elte.hu>
	<Pine.LNX.4.58.0406021411030.3403@ppc970.osdl.org>
	<20040603072146.GA14441@elte.hu>
	<20040603124448.GA28775@elte.hu>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2004 14:44:48 +0200
Ingo Molnar <mingo@elte.hu> wrote:


> - in exec.c, since address-space executability is a security-relevant
> item, we must clear the personality when we exec a setuid binary. I
> believe this is also a (small) security robustness fix for current
> 64-bit architectures.

I'm not sure I like that. This means I cannot earily force an i386 uname 
or 3GB address space on suid programs anymore on x86-64.

While in theory it could be a small security problem I think the utility
is much greater.

It's hard to see how setting NX could cause a security hole. The program
may crash, but it is unlikely to be exploitable.

-Andi
