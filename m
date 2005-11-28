Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbVK1SGb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbVK1SGb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 13:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVK1SGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 13:06:19 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18698 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932148AbVK1SGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 13:06:01 -0500
Date: Mon, 28 Nov 2005 18:05:55 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Kumar Gala <galak@gate.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [DRIVER MODEL] Allow overlapping resources for platform devices
Message-ID: <20051128180555.GB14557@flint.arm.linux.org.uk>
Mail-Followup-To: Kumar Gala <galak@gate.crashing.org>,
	Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0511281015060.25081-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0511281015060.25081-100000@gate.crashing.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2005 at 10:15:39AM -0600, Kumar Gala wrote:
> There are cases in which a device's memory mapped registers overlap
> with another device's memory mapped registers.  On several PowerPC
> devices this occurs for the MDIO bus, whose registers tended to overlap
> with one of the ethernet controllers.

Hrm, shouldn't the MDIO device be registered by the ethernet driver then?
The MDIO device is a child of the ethernet device - and this also brings
up the question about PM ordering - should the MDIO device be suspended
before or after the ethernet device.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
