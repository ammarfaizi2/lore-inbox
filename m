Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932482AbWFHCME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWFHCME (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jun 2006 22:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWFHCME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jun 2006 22:12:04 -0400
Received: from [198.99.130.12] ([198.99.130.12]:2270 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932482AbWFHCMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jun 2006 22:12:03 -0400
Date: Wed, 7 Jun 2006 22:11:49 -0400
From: Jeff Dike <jdike@addtoit.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Andrew Morton <akpm@osdl.org>, jamagallon@ono.com,
       linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: [PATCH] ignore smp_locks section warnings from init/exit code
Message-ID: <20060608021149.GA5567@ccure.user-mode-linux.org>
References: <20060607104724.c5d3d730.akpm@osdl.org> <20060608003153.36f59e6a@werewolf.auna.net> <20060607154054.cf4f2512.akpm@osdl.org> <20060607162326.3d2cc76b.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060607162326.3d2cc76b.rdunlap@xenotime.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2006 at 04:23:26PM -0700, Randy.Dunlap wrote:
> I currently only see this in an __exit section.
> Here is a patch that fixes it for me.

Cool, something equivalent makes the UML link a lot quieter.  I had to
add ".plt" and ".bss".  I'm guessing mine are false positives as well,
but have no idea how to check that.

I also think that adding these two sections would be UML-specific, but
that probably shouldn't hurt other arches.

				Jeff
