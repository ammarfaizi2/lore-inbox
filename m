Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbTJHTaR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 15:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261748AbTJHTaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 15:30:16 -0400
Received: from gprs148-130.eurotel.cz ([160.218.148.130]:38017 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261689AbTJHTaO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 15:30:14 -0400
Date: Wed, 8 Oct 2003 21:29:29 +0200
From: Pavel Machek <pavel@suse.cz>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup of compat_ioctl functions
Message-ID: <20031008192929.GC1035@elf.ucw.cz>
References: <200310081809.42859.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310081809.42859.arnd@arndb.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is my reworked patch for cleaning up compat_ioctl, with the main
> purpose of making it usable for s390. Every single change here should
> be trivial, but there are a lot of them.

Looks good to me. [I just scanned it...]

Perhaps it compat_ptr_u32(arg), that returns (u32 __user *) should be
invented? [Well, its used only 3 times, so maybe this is bad idea].

Also __u32 should not be used here, it looks too ugly and u32 is
okay. Same for __u16 and __u64. Its simple search&replace, and as you
are doing lots of changes, anyway....
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
