Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbVLGWWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbVLGWWz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbVLGWWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:22:55 -0500
Received: from cantor2.suse.de ([195.135.220.15]:5321 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750927AbVLGWWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:22:54 -0500
Date: Wed, 7 Dec 2005 23:22:46 +0100
From: Olaf Hering <olh@suse.de>
To: linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Sachin Sant <sachinp@in.ibm.com>
Subject: Re: [RFC] [PATCH] Adding ctrl-o sysrq hack support to 8250 driver
Message-ID: <20051207222246.GA22558@suse.de>
References: <438D8A3A.9030400@in.ibm.com> <20051130130429.GB25032@flint.arm.linux.org.uk> <43953440.9070102@in.ibm.com> <20051206171633.GB19664@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20051206171633.GB19664@flint.arm.linux.org.uk>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Dec 06, Russell King wrote:

> I'm still highly concerned about this whole idea.  Applying this patch
> _will_ without doubt inconvenience a lot of people who expect ^O to be
> received as normal.

If one boots with 'console=ttyS0', the 'ctrl o' should be handled only
on ttyS0. However, I'm not sure if anyone uses ^O in this situation via
the system console. In our case, ttyS0 is automatically activated via
add_preferred_console in arch/powerpc/kernel/setup-common.c.
If there is a clever way to handle ^O only for the system console, would
such a patch be accepted? I'm currently looking through the code to see
how it could be done.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
