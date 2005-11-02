Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965028AbVKBNpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965028AbVKBNpA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 08:45:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbVKBNpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 08:45:00 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:45328 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965028AbVKBNo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 08:44:59 -0500
Date: Wed, 2 Nov 2005 13:44:52 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch, rfc] LEDs support for collie
Message-ID: <20051102134452.GA4778@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Andrew Morton <akpm@osdl.org>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
	kernel list <linux-kernel@vger.kernel.org>
References: <20051102132145.GA14946@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051102132145.GA14946@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 02:21:45PM +0100, Pavel Machek wrote:
> This adds support for controlling LEDs on sharp zaurus sl-5500. It may
> look a little bit complex, but it probably needs to be complex --
> blinking is pretty much mandatory when you only have two leds, and we
> want to support charging led (controlled by kernel).

Isn't "blinking" a kind of policy, as is brightness (== duty cycle of
a high speed toggling)?  What if someone wants synchronised toggling?

I still think anything over a very simple interface being exported to
userspace is completely overkill and completely bloated.  Hell, I got
laughed at for creating an abstracted LEDs interface in the first
place because many thought the current version was far too bloated.

I _know_ people have issues with the current interface, whinging that
"it only exports the colour" but that's something which is actually
very trivially solvable and therefore _not_ a major problem to solve.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
