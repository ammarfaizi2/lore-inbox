Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261856AbVCUUTI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbVCUUTI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 15:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbVCUUTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 15:19:08 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:46604 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261856AbVCUUS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:18:56 -0500
Date: Mon, 21 Mar 2005 20:18:47 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jacques Goldberg <Jacques.Goldberg@cern.ch>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Need break driver<-->pci-device automatic association
Message-ID: <20050321201847.A16069@flint.arm.linux.org.uk>
Mail-Followup-To: Jacques Goldberg <Jacques.Goldberg@cern.ch>,
	Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58_heb2.09.0503181042470.8660@localhost.localdomain> <20050318165124.GC14952@kroah.com> <Pine.LNX.4.58_heb2.09.0503192021431.11358@localhost.localdomain> <20050321081638.GC2703@pazke> <20050321082228.A22099@flint.arm.linux.org.uk> <Pine.LNX.4.58_heb2.09.0503211336090.6491@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58_heb2.09.0503211336090.6491@localhost.localdomain>; from goldberg@phep2.technion.ac.il on Mon, Mar 21, 2005 at 01:39:30PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2005 at 01:39:30PM +0200, Jacques Goldberg wrote:
>         Here is a modem which cannot be used because it is grabbed by the
> serial driver:
> 
> 00:0f.0 Modem: ALi Corporation SmartLink SmartPCI561 56K Modem (prog-if 00
> [Generic])

Ok, this is what I wanted to know.

There seems to be growing evidence that 8250_pci should not claim the
"modem" class, but should match any such cards which do look like
serial ports by vendor/device IDs.  The problem is that dropping the
modem class id match could leave a fair number of people in the lurch,
but I'm game to try it and see.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
