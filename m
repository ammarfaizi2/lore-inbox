Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbWBHVRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbWBHVRP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 16:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964996AbWBHVRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 16:17:15 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:14779 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964993AbWBHVRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 16:17:14 -0500
Date: Wed, 8 Feb 2006 13:17:08 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc2-mm1
Message-Id: <20060208131708.f81b025e.pj@sgi.com>
In-Reply-To: <20060207220627.345107c3.akpm@osdl.org>
References: <20060207220627.345107c3.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The broken out patch set for 2.6.16-rc2-mm1 is not applying for me.

The very first patch, linus.patch, has 74 FAIL'd files. Just pulling
out the failing lines, I see some 180 lines of output, beginning with:

    Applying patch linus.patch
    patching file arch/arm/mach-s3c2410/Makefile
    Hunk #1 FAILED at 10.
    Hunk #2 FAILED at 29.
    2 out of 2 hunks FAILED -- rejects in file arch/arm/mach-s3c2410/Makefile
    patching file arch/arm/mm/proc-xscale.S
    Hunk #1 FAILED at 241.
    Hunk #2 FAILED at 260.
    2 out of 2 hunks FAILED -- rejects in file arch/arm/mm/proc-xscale.S
    patching file arch/cris/Makefile
    Hunk #1 FAILED at 119.
    1 out of 1 hunk FAILED -- rejects in file arch/cris/Makefile
    patching file arch/ia64/Kconfig
    Hunk #1 FAILED at 194.
    Hunk #2 succeeded at 375 with fuzz 2 (offset 2 lines).
    1 out of 2 hunks FAILED -- rejects in file arch/ia64/Kconfig
    patching file arch/ia64/kernel/sal.c
    Hunk #1 FAILED at 14.
    Hunk #2 succeeded at 288 with fuzz 2 (offset 73 lines).
    Hunk #3 FAILED at 408.
    2 out of 3 hunks FAILED -- rejects in file arch/ia64/kernel/sal.c


Looking hastily at the arch/arm/mach-s3c2410/Makefile, it looked like
linus.patch was trying to add gpio support to a Makefile that already
had it.

However ... I've been having a bad hair day with source control.  So,
if the above looks like operator error, it probably is.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
