Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbVHRHH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbVHRHH3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 03:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbVHRHH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 03:07:29 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48144 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750805AbVHRHH2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 03:07:28 -0400
Date: Thu, 18 Aug 2005 08:07:23 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "Mukund JB`." <mukundjb@esntechnologies.co.in>
Cc: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: How to support partitions in driver?
Message-ID: <20050818080722.A3966@flint.arm.linux.org.uk>
Mail-Followup-To: "Mukund JB`." <mukundjb@esntechnologies.co.in>,
	linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
References: <3AEC1E10243A314391FE9C01CD65429B3845@mail.esn.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3AEC1E10243A314391FE9C01CD65429B3845@mail.esn.co.in>; from mukundjb@esntechnologies.co.in on Thu, Aug 18, 2005 at 12:22:55PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2005 at 12:22:55PM +0530, Mukund JB`. wrote:
> I have few basic queries regarding my partition implementation in my Sd
> driver. 
> Sorry for asking such petty things here. But, somehow it's not working &
> I am made to ask it here.

Why don't you use the MMC/SD layer already merged into the kernel
instead of rewriting your own.  Grab a copy of Andrew Morton's
kernel, and look at the code in drivers/mmc and include/linux/mmc.

There are three host drivers there already.  I'm sure you can work
out how to interface the existing framework to your device.

And suddenly you can take advantage of the already existing mmc
block device support, which does support partitions, and does
manage to get hot swapping block devices more or less correct.
(and if it doesn't, it'll be one less driver to fix later.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
