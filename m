Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754282AbWKZXJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbWKZXJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 18:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754306AbWKZXJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 18:09:58 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:52232 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1754278AbWKZXJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 18:09:58 -0500
Date: Sun, 26 Nov 2006 23:09:51 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: Build breakage ...
Message-ID: <20061126230951.GB30767@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
References: <20061126224928.GA22285@linux-mips.org> <20061126230515.GA30767@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061126230515.GA30767@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2006 at 11:05:16PM +0000, Russell King wrote:
> Ditto on ARM.  This level of breakage is simply not acceptable soo
> close to a release, and needs the change reverting.
> 
> Note that on ARM, "allmodconfig" is really meaningless since it only
> tests one configuration.  Ditto for the other all*config options.
> kautobuild (or building a range of defconfigs) is the only real way
> to check for breakage on ARM.

BTW, it should be pointed out that ARM has for the last I don't know
how many months been checking the type of "flags" passed into
local_irq_save() and friends...  If a generic solution is adopted
(during the merge phase _only_ please) then the ARM specific version
should probably be removed.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
