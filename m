Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932473AbVJCRWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbVJCRWn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 13:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbVJCRWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 13:22:43 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:59891 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932473AbVJCRWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 13:22:42 -0400
Date: Mon, 3 Oct 2005 10:22:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Dave B. Sharp" <daveb_sharp@yahoo.ca>
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: ppc boot entry point
Message-ID: <20051003172241.GB6735@smtp.west.cox.net>
References: <20051003153527.53128.qmail@web32909.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051003153527.53128.qmail@web32909.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 11:35:27AM -0400, Dave B. Sharp wrote:

> Hey there,
> Can anyone tell me how to find te entry point (i.e.
> address) into the kernel, when control is passed from
> the boot loader?
> Where are the arguements such as the boot parameters.
> I am compiling for a generic ppc kernel at this point.

This is PowerPC specific stuff.  Setting aside pmac's, and boards which
use U-Boot, and other boards with a firmware that sets up the
environment directly for the vmlinux file (which is the kernel proper)
to run, the code under arch/ppc/boot/simple/ is typically run.  This
code is linked to run at 8mb and will relocate itself there, regardless
of where the firmware actually loaded it into memory.  This linked
address may be changed by enabling the ADVANCED_OPTIONS option and
choosing an alternate address.  This really only makes sense on machines
where loading at 8mb won't work as you have 8mb or less of memory.

-- 
Tom Rini
http://gate.crashing.org/~trini/
