Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262412AbULCRJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbULCRJR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 12:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbULCRJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 12:09:16 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:7173 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262412AbULCRJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 12:09:00 -0500
Date: Fri, 3 Dec 2004 17:08:53 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Tigran Aivazian <tigran@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch-2.6.x] fix compile failure if CONFIG_PROC_KCORE not set.
Message-ID: <20041203170853.B24118@flint.arm.linux.org.uk>
Mail-Followup-To: Tigran Aivazian <tigran@veritas.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0412031632310.4221@ezer.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.61.0412031632310.4221@ezer.homenet>; from tigran@veritas.com on Fri, Dec 03, 2004 at 05:01:57PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2004 at 05:01:57PM +0000, Tigran Aivazian wrote:
> I know that /proc/kcore support cannot be disabled by normal means but 
> since it is conditional upon CONFIG_PROC_KCORE in fs/proc/Makefile it 
> makes sense to make sure that kernel compiles even if it is disabled 
> manually by editing .config and include/linux/autoconf.h or if in the 
> future CONFIG_PROC_KCORE becomes a real CONFIG_ variable.

CONFIG_PROC_KCORE currently exists to allow ARM and others to drop
the nonfunctional /proc/kcore support from the kernel.  It wasn't
intended to be a configuration option as such.

However, if you wish it to be so, there's no problem provided that
the architectures are fixed up as you've done for x86, and that the
ability for certain architectures to ensure that this is never
selected is preserved.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
