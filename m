Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbVHQKVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbVHQKVt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 06:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751050AbVHQKVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 06:21:49 -0400
Received: from mail.suse.de ([195.135.220.2]:27297 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751048AbVHQKVt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 06:21:49 -0400
From: Andreas Schwab <schwab@suse.de>
To: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Undefined behaviour with get_cpu_vendor
References: <20050817095423.625.qmail@thales.mathematik.uni-ulm.de>
X-Yow: Somewhere in Tenafly, New Jersey, a chiropractor is viewing
 ``Leave it to Beaver''!
Date: Wed, 17 Aug 2005 12:21:44 +0200
In-Reply-To: <20050817095423.625.qmail@thales.mathematik.uni-ulm.de>
	(Christian Ehrhardt's message of "Wed, 17 Aug 2005 11:54:23 +0200")
Message-ID: <jey870uamf.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de> writes:

> --- arch/i386/kernel/apic.c     2005-03-26 04:28:38.000000000 +0100
> +++ arch/i386/kernel/apic.c.new 2005-08-17 11:54:48.070499352 +0200
> @@ -703,14 +703,14 @@
>  static int __init detect_init_APIC (void)
>  {
>         u32 h, l, features;
> -       extern void get_cpu_vendor(struct cpuinfo_x86*);
> +       extern void get_cpu_vendor(struct cpuinfo_x86*, int);

Move the declaration to a header and include that here.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
