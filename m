Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265814AbUATWqs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 17:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265821AbUATWqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 17:46:48 -0500
Received: from [213.4.129.129] ([213.4.129.129]:7484 "EHLO tsmtp16.mail.isp")
	by vger.kernel.org with ESMTP id S265814AbUATWpf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 17:45:35 -0500
Date: Tue, 20 Jan 2004 23:44:03 +0100
From: Diego Calleja <grundig@teleline.es>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] disallow DRM on 386
Message-Id: <20040120234403.73be7b2a.grundig@teleline.es>
In-Reply-To: <20040120212421.GF12027@fs.tum.de>
References: <20040120212421.GF12027@fs.tum.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 20 Jan 2004 22:24:21 +0100 Adrian Bunk <bunk@fs.tum.de> escribió:

> I got the following compile error in 2.6.1-mm5 with X86_CMPXCHG=n.
> This problem is not specific to -mm, and it always occurs when you 
> include support for the 386 cpu (oposed to the 486 or later cpus) since 
> in this case X86_CMPXCHG=n and therefoore cmpxchg isn't defined in 
> include/asm-i386/system.h .
> 
> The patch below disallows DRM if X86_CMPXCHG=n.

I got a "cmpxchg not defined" error when compiling the drm stuff in -mm5.
When I looked at the configuration, I saw that all the cpus types had been selected
(I didn't even realize of your stuuf and menuconfig put the defaults). I removed
all types of cpus except PIII and it compiled.
