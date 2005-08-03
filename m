Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbVHCIBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVHCIBq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 04:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbVHCIBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 04:01:45 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:14856 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262138AbVHCH7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 03:59:20 -0400
Date: Wed, 3 Aug 2005 08:59:10 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>, Tony Lindgren <tony@atomide.com>,
       tuukka.tikkanen@elektrobit.com
Subject: Re: [PATCH] no-idle-hz aka dynamic ticks
Message-ID: <20050803085910.A29066@flint.arm.linux.org.uk>
Mail-Followup-To: Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	ck list <ck@vds.kolivas.org>, Tony Lindgren <tony@atomide.com>,
	tuukka.tikkanen@elektrobit.com
References: <200508022225.31429.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200508022225.31429.kernel@kolivas.org>; from kernel@kolivas.org on Tue, Aug 02, 2005 at 10:25:26PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2005 at 10:25:26PM +1000, Con Kolivas wrote:
> As promised, here is an updated patch for the newly released 2.6.13-rc5.
> Boots and runs fine on P4HT (SMP+SMT kernel) built with gcc 4.0.1.

Please note that ARM already has dyn-tick merged in mainline.  If
we're going to be adding dyn-tick for x86, please do it in a way
that we don't create another goddamned awful mess like we did for
the ARM IRQ stuff.

I notice that this version does some things in a different way to
the ARM version - for instance, it doesn't pass the "number of
jiffies to skip" to the arch reprogram function.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
