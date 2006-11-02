Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752510AbWKBIbS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbWKBIbS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 03:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752511AbWKBIbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 03:31:17 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:37646 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1752510AbWKBIbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 03:31:17 -0500
Date: Thu, 2 Nov 2006 08:31:09 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Guillermo Marcus Martinez <marcus@ti.uni-mannheim.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mmaping a kernel buffer to user space
Message-ID: <20061102083109.GB1377@flint.arm.linux.org.uk>
Mail-Followup-To: Guillermo Marcus Martinez <marcus@ti.uni-mannheim.de>,
	linux-kernel@vger.kernel.org
References: <4547150F.8070408@ti.uni-mannheim.de> <loom.20061101T120846-320@post.gmane.org> <454899E9.1090900@ti.uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454899E9.1090900@ti.uni-mannheim.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 01:58:17PM +0100, Guillermo Marcus Martinez wrote:
> My suggestion would be to add two functions: pci_map_consistent() and
> dma_map_coherent() to address this issue, and their corresponding
> unmap's. That will make sure all that is needed is done, is a clean and
> consistent with the pci_ and dma_ APIs, and fills a mmap requirement not
> covered by the other functions.

You might want to look through include/asm-arm/dma-mapping.h to see if
an architecture already has considered that and the interface they
implemented.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
