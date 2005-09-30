Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbVI3OC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbVI3OC5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 10:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030302AbVI3OC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 10:02:57 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43791 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1030301AbVI3OC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 10:02:56 -0400
Date: Fri, 30 Sep 2005 15:02:48 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: dwmw2@infradead.org, kernel list <linux-kernel@vger.kernel.org>,
       linux-mtd@lists.infradead.org
Subject: Re: [patch] switch mtd to new driver model & cleanups
Message-ID: <20050930140247.GA28856@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>, dwmw2@infradead.org,
	kernel list <linux-kernel@vger.kernel.org>,
	linux-mtd@lists.infradead.org
References: <20050930121741.GA5506@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930121741.GA5506@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2005 at 02:17:41PM +0200, Pavel Machek wrote:
> Switch mtd to new power management.

You don't need to do it this way - and this will probably mess up the
SA1100 suspend code.  MTD map drivers should probably be converted to
the driver model rather than the core so that the PM ordering can be
correctly handled.

(Consider the case where there's flash on a daughter board accessed
over some kind of bridge.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
