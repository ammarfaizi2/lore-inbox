Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbVAMIul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbVAMIul (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 03:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVAMIul
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 03:50:41 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:62095 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261308AbVAMIug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 03:50:36 -0500
Date: Thu, 13 Jan 2005 09:50:35 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel List <linux-kernel@vger.kernel.org>, ecashin@coraid.com
Subject: Re: [BUG] ATA over Ethernet __init calling __exit
Message-ID: <20050113085035.GC2815@suse.de>
References: <20050113000949.A7449@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050113000949.A7449@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13 2005, Russell King wrote:
> In addition, please shoot the author in the other foot for:
> 
> config ATA_OVER_ETH
>         tristate "ATA over Ethernet support"
>         depends on NET
>         default m               <==== this line.
> 
> That's not nice for embedded guys who do a "make xxx_defconfig" and
> unsuspectingly end up with ATA over Ethernet built in for their
> platform.

That annoyed me, too. There's no reason for standard kernel driver
modules to assume they should be selected, especially true for something
as special case as ata over ethernet.

-- 
Jens Axboe

