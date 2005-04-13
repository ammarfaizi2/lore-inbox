Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVDMLvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVDMLvP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 07:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbVDMLvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 07:51:15 -0400
Received: from mail.sysgo.com ([62.8.134.5]:62866 "EHLO mail.sysgo.com")
	by vger.kernel.org with ESMTP id S261310AbVDMLu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 07:50:59 -0400
From: Rolf Offermanns <roffermanns@sysgo.com>
Organization: SYSGO AG
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: mmap + dma_alloc_coherent
Date: Wed, 13 Apr 2005 13:51:52 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200504131243.48694.roffermanns@sysgo.com> <20050413121937.A14087@flint.arm.linux.org.uk>
In-Reply-To: <20050413121937.A14087@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504131351.53105.roffermanns@sysgo.com>
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.2-8; AVE: 6.30.0.7; VDF: 6.30.0.92; host: mailgate2.sysgo.com)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 April 2005 13:19, Russell King wrote:
> This has come up before.  ARM implements dma_mmap_*() to allow this
> to happen, but it never got propagated to the other architectures.
I know, this is why I referenced the other LKML threads. What keeps these 
functions from being propagated to the other archs? Are there still 
unresolved issues? (x86 not marking RAM pages reserved would be one I 
assume)?
>
> Here's the (untested) x86 version.  There may be a problem with
> x86 not marking the pages reserved, which is required for
> remap_pfn_range() to work.

So the fact that remap_pfn_range() does not work on pages allocated with 
__get_free_pages() is an x86-only issue? Or is it by design?

-Rolf
-- 
Rolf Offermanns <roffermanns@sysgo.com>
SYSGO AG     Tel.: +49-6136-9948-0
Am Pfaffenstein 14   Fax: +49-6136-9948-10
55270 Klein-Winternheim  http://www.sysgo.com

