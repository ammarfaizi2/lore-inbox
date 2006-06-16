Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWFPTcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWFPTcM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 15:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751354AbWFPTcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 15:32:11 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:58381 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750796AbWFPTcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 15:32:10 -0400
Date: Fri, 16 Jun 2006 20:31:14 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Milan Svoboda <msvoboda@ra.rockwell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] no_pci_serial
Message-ID: <20060616193114.GA7257@flint.arm.linux.org.uk>
Mail-Followup-To: Milan Svoboda <msvoboda@ra.rockwell.com>,
	linux-kernel@vger.kernel.org
References: <4492CC64.80501@ra.rockwell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4492CC64.80501@ra.rockwell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2006 at 03:21:08PM +0000, Milan Svoboda wrote:
> This patch allows to compile 8250 driver on systems without pci bus.

inb/outb/readb/writeb methods have nothing to do with the presence of
a PCI bus or not, so the patch is wrong - and it actually breaks a lot
of machine implementations which use this.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
