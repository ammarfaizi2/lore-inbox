Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbVC1TBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbVC1TBL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 14:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVC1TBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 14:01:11 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22542 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262002AbVC1TBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 14:01:08 -0500
Date: Mon, 28 Mar 2005 20:01:04 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Eran Mann <emann@mrv.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] paport related OOPS since 2.6.11-bk7
Message-ID: <20050328200104.B2222@flint.arm.linux.org.uk>
Mail-Followup-To: Eran Mann <emann@mrv.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <424834B7.5080805@mrv.com> <20050328175837.A2222@flint.arm.linux.org.uk> <42483C84.6000700@mrv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <42483C84.6000700@mrv.com>; from emann@mrv.com on Mon, Mar 28, 2005 at 07:19:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 07:19:00PM +0200, Eran Mann wrote:
> Mar 28 17:13:44 eran kernel: EIP is at parport_pc_pci_remove+0x18/0x40 [parport_pc]

Are you sure you reinstalled the kernel modules after rebuilding?
parport_pc_pci_remove() was 0x40 bytes long before, and still seems
to be.  Also, the Code: lines are identical.  This means you're
running the same (unpatched) code as you were before, so you aren't
actually running my fix.

Can you double-check please?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
