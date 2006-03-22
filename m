Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWCVNxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWCVNxp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 08:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751247AbWCVNxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 08:53:45 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:50188 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751245AbWCVNxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 08:53:44 -0500
Date: Wed, 22 Mar 2006 13:53:37 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ucb1x00 audio & zaurus touchscreen
Message-ID: <20060322135337.GA26357@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@suse.cz>, rpurdie@rpsys.net,
	lenz@cs.wisc.edu, kernel list <linux-kernel@vger.kernel.org>
References: <20060322122052.GN14075@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060322122052.GN14075@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 01:20:53PM +0100, Pavel Machek wrote:
> First, I'd like to ask: what is status of ucb1x00 audio in 2.6? I do
> have .c file here, but do not have corresponding header files...

I never included the ucb1x00 audio patch into mainline because it
depended on some obsolete SA11x0 OSS audio support, and I haven't had
time to:

(a) finish my SA11x0 ALSA audio support (the stuff which is in mainline
    is under the guise of being generic, but is actually completely ipaq
    specific.)
(b) convert the ucb1x00 stuff to use this generic ALSA support.

Plus there's issues surrounding where it should live (as ever).  It
would be stretched between drivers/mfd and sound/arm and would be very
ARM specific.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
