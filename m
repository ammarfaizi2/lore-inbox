Return-Path: <linux-kernel-owner+w=401wt.eu-S1751448AbXAKVIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbXAKVIS (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 16:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbXAKVIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 16:08:18 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:47213 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbXAKVIR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 16:08:17 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Thu, 11 Jan 2007 22:08:12 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: Linux-2.6.20-rc4 - Kernel panic!
To: Sunil Naidu <akula2.shark@gmail.com>
cc: linux-kernel@vger.kernel.org
In-Reply-To: <8355959a0701111211m416e202bx637bca22f8fca826@mail.gmail.com>
Message-ID: <tkrat.113437f9eecab84a@s5r6.in-berlin.de>
References: <8355959a0701110300j33d28f54y67728eb847c7ba31@mail.gmail.com> 
 <45A681E5.6060502@s5r6.in-berlin.de>
 <8355959a0701111211m416e202bx637bca22f8fca826@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sunil Naidu wrote:
> compiling a driver as module has same affect (while
> loading/booting of kernel) compare to compiling a driver as kernel
> builtin feature?

LKML is not the place for such questions.

Modules have to be loaded from a filesystem while built-in features are
available from the start.

The bootloader only loads the kernel image and optionally an initrd. The
initrd is used as a preliminary root filesystem which may contain kernel
modules to load to make the real root filesystem accessible. That's what
distributors do because they don't know in advance which drivers their
users will actually need. Endusers who build their own kernels might as
well compile all drivers that are needed for access to the root
filesystem into the kernel image and work without initrd.
-- 
Stefan Richter
-=====-=-=== ---= -=-==
http://arcgraph.de/sr/

