Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbTL1TzR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 14:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbTL1TzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 14:55:17 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:47371 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262009AbTL1TzN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 14:55:13 -0500
Date: Sun, 28 Dec 2003 19:55:09 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: linux-pcmcia <linux-pcmcia@lists.infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] fix yenta memleak
Message-ID: <20031228195509.D20278@flint.arm.linux.org.uk>
Mail-Followup-To: Daniel Ritz <daniel.ritz@gmx.ch>,
	linux-pcmcia <linux-pcmcia@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200312281852.14336.daniel.ritz@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200312281852.14336.daniel.ritz@gmx.ch>; from daniel.ritz@gmx.ch on Sun, Dec 28, 2003 at 06:52:14PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 28, 2003 at 06:52:14PM +0100, Daniel Ritz wrote:
> fix a memleak on yenta_socket unload.
> against 2.6.0

This looks fine; we don't allow the unload to continue until we've
made sure that sysfs has finished using sock, which prevents us
kfree'ing it while it's still in use.

I'll add this to the outgoing queue of pcmcia patches.  Thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
