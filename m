Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262231AbVBQOnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262231AbVBQOnm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 09:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVBQOni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 09:43:38 -0500
Received: from ms005msg.fastwebnet.it ([213.140.2.50]:62964 "EHLO
	ms005msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S262231AbVBQOme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 09:42:34 -0500
Date: Thu, 17 Feb 2005 15:42:50 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: marc.cramdal@gmail.com
Cc: bruno.virlet@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: AMD 64 and Kernel AGPart support
Message-ID: <20050217154250.110f4615@localhost>
In-Reply-To: <200502171508.33052.marc.cramdal@gmail.com>
References: <4213AB2B.2050604@giesskaennchen.de>
	<200502171508.33052.marc.cramdal@gmail.com>
X-Mailer: Sylpheed-Claws 0.9.12a (GTK+ 1.2.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2005 15:08:32 +0100
Marc Cramdal <bruno.virlet@gmail.com> wrote:

> I have an AMD 64 (gentoo compiled for amd64) and I would like to
> succeed in my video driver installation (ATI Radeon 9250 :-/). I would
> need the agpgart support for the Sis Chipset, but all the entry for
> agpgart are grayed, I can't change anything (Kernel 2.6.9, 2.6.10 ...)
> 
> So is it normal or a bug ?? , or am I making a mistake.


I have an AMD Athlon64 with Radeon 9200SE on VIA K8T800 Chipset... and
AGP works fine with only CONFIG_AGP_AMD64 enabled.

The fact is that these AMD processors have an "on-CPU northbridge" for
AGP, and the support for the various external AGP bridges (VIA, SiS,
Nvidia) is provided directly in "drivers/char/agp/amd64-agp.c" driver
(selected by CONFIG_AGP_AMD64).

Reading "drivers/char/agp/amd64-agp.c" I can see that "SIS 755" chipset
is supported.

If you have a chipset that isn't supported you can always try with the
"agp_try_unsupported=1" option (as stated in the HELP of
CONFIG_AGP_AMD64).

> 
> NB: one of my friends made the test, without AMD64 and exactly the
> same kernel he can check these options within agpgart...

You don't have to be on a i386 to see the options avaiable for i386...
just do a "make menuconfig ARCH=i386" and you are done!

But if you are on x86_64, why do you want to enable drivers for other
architectures?

-- 
	Paolo Ornati
	Gentoo Linux (kernel 2.6.10-gentoo-r7)
