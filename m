Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbUCSKbo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 05:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbUCSKbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 05:31:44 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44302 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262556AbUCSKbn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 05:31:43 -0500
Date: Fri, 19 Mar 2004 10:31:26 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Tom Rini <trini@kernel.crashing.org>
Subject: Re: [CFT] inflate.c rework arch testing needed
Message-ID: <20040319103126.A12519@flint.arm.linux.org.uk>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	linux-kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
	Tom Rini <trini@kernel.crashing.org>
References: <20040318231006.GK11010@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040318231006.GK11010@waste.org>; from mpm@selenic.com on Thu, Mar 18, 2004 at 05:10:06PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 05:10:06PM -0600, Matt Mackall wrote:
> I've reworked the mess that is lib/inflate.c, including:

Please don't - this will probably break the PIC decompressor on ARM.

There are un-merged patches in the pipeline which make this all work
correctly with todays toolchains - which mostly means getting rid of
all static data to make the compiler produce the right relocations.

Yes its stupid, but there seems to be no other way to do this with
the ELF toolchains we have available to us now.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
