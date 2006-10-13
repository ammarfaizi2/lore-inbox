Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbWJMIAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbWJMIAp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 04:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbWJMIAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 04:00:45 -0400
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:48145 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750800AbWJMIAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 04:00:44 -0400
Date: Fri, 13 Oct 2006 09:00:35 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jeff Garzik <jeff@garzik.org>
Cc: oakad@yahoo.com, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/{mmc,misc}: handle PCI errors on resume
Message-ID: <20061013080035.GD28654@flint.arm.linux.org.uk>
Mail-Followup-To: Jeff Garzik <jeff@garzik.org>, oakad@yahoo.com,
	Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <20061011214809.GA21756@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061011214809.GA21756@havoc.gtf.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 05:48:09PM -0400, Jeff Garzik wrote:
> Since pci_enable_device() is one of the first things called in the
> resume step, take the minimalist approach and return immediately, if
> pci_enable_device() fails during resume.

NAK, for the same reason as for drivers/serial.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
