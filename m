Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265090AbTFRIa5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 04:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbTFRIa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 04:30:57 -0400
Received: from ns.suse.de ([213.95.15.193]:55056 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265090AbTFRIa4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 04:30:56 -0400
Date: Wed, 18 Jun 2003 10:44:52 +0200
From: Andi Kleen <ak@suse.de>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.5.72 x86-generic missing enable_apic_mode()
Message-ID: <20030618084452.GD23037@wotan.suse.de>
References: <200306180827.h5I8Rtl27217@freya.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306180827.h5I8Rtl27217@freya.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 01:27:55AM -0700, Adam J. Richter wrote:
> 	x86-generic in 2.5.72 does not compile, because
> include/asm-i386/mach-generic/mach_apic.h does not define
> enable_apic_mode().  Although I kludged around this, by
> just defining enable_apic_mode() as nothing (since it is
> apparently nothing for all x86 platforms except es7000),
> I imagine that the correct definition is
> 
> #define enable_apic_mode (genapic->enable_apic_mode)
> 
> 	...along with some other changes to declare
> genapic->enable_apic_mode and initialize it for each platform
> type.

It should be enough to add it to the genapic structure in
asm-i386/genapic.h and also to the APIC_INIT macro in the same file.

(assuming that it is properly defined for default,bigsmp,summit) 

-Andi
