Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272327AbTHILRg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 07:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272328AbTHILRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 07:17:35 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:53509 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S272327AbTHILRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 07:17:35 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Jeff Garzik <jgarzik@pobox.com>, Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: [patch 2.4 1/2] backport 2.6 x86 cpu capabilities
Date: Sat, 9 Aug 2003 11:51:23 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <200308081119.h78BJWQ5015656@harpo.it.uu.se> <3F33A257.7050101@pobox.com>
In-Reply-To: <3F33A257.7050101@pobox.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308091150.59006.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 August 2003 15:15, Jeff Garzik wrote:

Hi Jeff,

> >>-#define NCAPINTS	4	/* Currently we have 4 32-bit words worth of info */
> >>+#define NCAPINTS	6	/* Currently we have 6 32-bit words worth of info */
> > If you change NCAPINTS you also have to change the hardcoded
> > struct offset X86_VENDOR_ID in arch/i386/kernel/head.S. Otherwise
> > nasty stuff happen at boot since boot_cpu_data gets broken.
> hmmm, reality doesn't seem to bear that out...  I made the same change
> to 2.6, without touching head.S, and life continues without "nasty
> stuff" AFAICS.
> Do both 2.4 and 2.6 need this change?  And, why didn't 2.6 break?

Mikael is right. At least 2.4 need this change, otherwise APIC may break.
2.6 might break also in some cases.

ciao, Marc

