Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265244AbUFRPqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265244AbUFRPqQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 11:46:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265226AbUFRPpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 11:45:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:52914 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265245AbUFRPnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 11:43:23 -0400
Date: Fri, 18 Jun 2004 08:40:45 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: lundby@ameritech.net, davej@codemonkey.org.uk,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] undefined reference to
 `acpi_processor_register_performance
Message-Id: <20040618084045.0ce7b747.rddunlap@osdl.org>
In-Reply-To: <20040618112549.GF16097@redhat.com>
References: <40D20080.9040909@ameritech.net>
	<20040617201243.4ebfc9b2.rddunlap@osdl.org>
	<40D26DD5.60809@ameritech.net>
	<20040617215812.105c67d0.rddunlap@osdl.org>
	<20040618112549.GF16097@redhat.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004 12:25:49 +0100 Dave Jones wrote:

| On Thu, Jun 17, 2004 at 09:58:12PM -0700, Randy.Dunlap wrote:
|  > 
|  > Several CPU_FREQ options need ACPI_PROCESSOR interfaces
|  > to build.
| 
| Hmm, it should be optional. Ie, if you don't have ACPI enabled,
| you should still be able to use these drivers (the k7 one at least),
| you just won't be able to use the ACPI fallback.

Hm, I see what you mean, but how do we handle source files that
call an optional kernel API (depending on CONFIG_xyz)?

IOW, building a cpufreq driver in-kernel that wants to call
acpi_processor_register_performance(), where CONFIG_ACPI_PROCESSOR=m,
needs to be prevented....

--
~Randy
