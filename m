Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbVKOEBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbVKOEBH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 23:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVKOEBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 23:01:07 -0500
Received: from ozlabs.org ([203.10.76.45]:12957 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932360AbVKOEBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 23:01:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17273.23926.674580.100553@cargo.ozlabs.ibm.com>
Date: Tue, 15 Nov 2005 15:00:54 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org, mikey@neuling.org
Subject: Re: [PATCH] Allow arch to veto PC speaker beeper initialization
In-Reply-To: <20051114195532.3500080b.akpm@osdl.org>
References: <17273.16792.850639.195427@cargo.ozlabs.ibm.com>
	<20051114195532.3500080b.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> We can avoid all the ifdef nasties by adding
> 
> static int pcspkr_arch_init(void) __attribute__((weak))
> {
> 	return 0;
> }
> 
> in pcspkr.c.
> 
> It'll bloat the kernel by a few bytes.

I like it.  We'll do a new patch, if you haven't made the change
already yourself.

Paul.
