Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262200AbVBXKPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262200AbVBXKPX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 05:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVBXKOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 05:14:23 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54283 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262200AbVBXKDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 05:03:37 -0500
Date: Thu, 24 Feb 2005 10:03:32 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adam Belay <abelay@novell.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] PCI bridge driver rewrite
Message-ID: <20050224100332.A26582@flint.arm.linux.org.uk>
Mail-Followup-To: Adam Belay <abelay@novell.com>, greg@kroah.com,
	linux-kernel@vger.kernel.org
References: <1109226122.28403.44.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1109226122.28403.44.camel@localhost.localdomain>; from abelay@novell.com on Thu, Feb 24, 2005 at 01:22:01AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 01:22:01AM -0500, Adam Belay wrote:
> 5.) write a bridge driver for Cardbus hardware

We have this already - it's called "yenta".

What you need to be aware of is that cardbus hardware is special - it
may change its resource requirements at any time, both in terms of the
number of BUS IDs it wishes to consume, and the number and size of
IO and memory resources.

Note also that if a cardbus bridge isn't on the root bus (it happens on
some laptops) these resource changes may impact on upstream bridges and
devices.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
