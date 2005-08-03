Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbVHCJLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbVHCJLR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 05:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbVHCJLD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 05:11:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:61147 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262171AbVHCJKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 05:10:34 -0400
Date: Wed, 3 Aug 2005 11:10:31 +0200
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Fix 32-bit thread debugging on x86_64
Message-ID: <20050803091031.GL10895@wotan.suse.de>
References: <20050731200557.GA4156@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050731200557.GA4156@nevyn.them.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 31, 2005 at 04:05:58PM -0400, Daniel Jacobowitz wrote:
> The IA32 ptrace emulation currently returns the wrong registers for
> fs/gs; it's returning what x86_64 calls gs_base.  We need regs.gsindex
> in order for GDB to correctly locate the TLS area.  Without this patch,
> the 32-bit GDB testsuite bombs on a 64-bit kernel.  With it, results
> look about like I'd expect, although there are still a handful of
> kernel-related failures (vsyscall related?).

Looks good. Thanks.

-Andi

