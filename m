Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbUKQTAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbUKQTAr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 14:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbUKQS7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 13:59:08 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:34189 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262442AbUKQS5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 13:57:47 -0500
Date: Wed, 17 Nov 2004 19:57:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: Nickolai Zeldovich <kolya@MIT.EDU>, linux-kernel@vger.kernel.org,
       csapuntz@stanford.edu, hiroit@mcn.ne.jp
Subject: Re: [patch] Fix GDT re-load on ACPI resume
Message-ID: <20041117185703.GB6952@openzaurus.ucw.cz>
References: <16A54BF5D6E14E4D916CE26C9AD305758EF0BA@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD305758EF0BA@pdsmsx402.ccr.corp.intel.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 	movw	_0x0e00 + 'i', %fs:(0x12)
> >
> > 	# need a gdt
> >+	.byte	0x66			# force 32-bit operands in case
> >+					# the GDT is past 16 megabytes
> > 	lgdt	real_save_gdt - wakeup_code
> >
> > 	movl	real_save_cr0 - wakeup_code, %eax
> There is a patch from hiroit@mcn.ne.jp to fix the GDT issue. You can try
> it.

Well, replacing lgdt with lgdtl (above) seems like nicer solution than
attachment...
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

