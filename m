Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbVJ1HzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbVJ1HzT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 03:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbVJ1HzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 03:55:19 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32778 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751277AbVJ1HzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 03:55:18 -0400
Date: Fri, 28 Oct 2005 08:55:08 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: John Bowler <jbowler@acm.org>
Cc: "'Deepak Saxena'" <dsaxena@plexity.net>, linux-kernel@vger.kernel.org,
       linux-arm-kernel@lists.arm.linux.org.uk, trivial@rustcorp.com.au
Subject: Re: [PATCH] 2.6.14 drivers/mtd/maps/ixp4xx.c: remove compiler warning from ioremap assignment
Message-ID: <20051028075508.GE5044@flint.arm.linux.org.uk>
Mail-Followup-To: John Bowler <jbowler@acm.org>,
	'Deepak Saxena' <dsaxena@plexity.net>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.arm.linux.org.uk, trivial@rustcorp.com.au
References: <000f01c5db86$ca148450$1001a8c0@kalmiopsis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000f01c5db86$ca148450$1001a8c0@kalmiopsis>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2005 at 11:13:59PM -0700, John Bowler wrote:
> Trivial fix for a compiler warning: info->map.map_priv_1 is
> (unsigned long), ioremap returns a pointer.  (Probably the
> result of improved compiler warnings in >2.6.12).

This is wrong.  You should be using map.virt (which has the correct
type) and not map.map_priv_1.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
