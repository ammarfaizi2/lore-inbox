Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbVHOInF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbVHOInF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 04:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbVHOInF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 04:43:05 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:10000 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932256AbVHOInE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 04:43:04 -0400
Date: Mon, 15 Aug 2005 09:42:59 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Max Asbock <masbock@us.ibm.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, vernux@us.ibm.com
Subject: Re: [PATCH] Add removal schedule of register_serial/unregister_serial to appropriate file
Message-ID: <20050815094259.B19811@flint.arm.linux.org.uk>
Mail-Followup-To: Max Asbock <masbock@us.ibm.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, vernux@us.ibm.com
References: <20050623142335.A5564@flint.arm.linux.org.uk> <20050714203321.E10410@flint.arm.linux.org.uk> <1123867834.17335.73.camel@w-amax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1123867834.17335.73.camel@w-amax>; from masbock@us.ibm.com on Fri, Aug 12, 2005 at 10:30:34AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 12, 2005 at 10:30:34AM -0700, Max Asbock wrote:
> I am converting the ibmasm driver that uses (un)register_serial to use
> serial_8250_(un)register_port. However I find function prototypes for
> the new interfaces only in linux/drivers/char/8250.h. Is there a reason
> there aren't any extern declarations for these functions in
> linux/include/serial.h or linux/include/serial_8250.h?

Probably because nothing outside drivers/serial uses these functions at
the moment.

They could be moved to include/linux/serial_8250.h though.  Patch welcome.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
