Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbUEADdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbUEADdc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 23:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUEADdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 23:33:32 -0400
Received: from adsl-67-65-14-122.dsl.austtx.swbell.net ([67.65.14.122]:35539
	"EHLO laptop.michaels-house.net") by vger.kernel.org with ESMTP
	id S261821AbUEADdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 23:33:23 -0400
Subject: Re: [PATCH 2.4] add SMBIOS information to /proc/smbios -- UPDATE 2
From: Michael Brown <mebrown@michaels-house.net>
To: Lev Makhlis <mlev@despammed.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200404302009.49576.mlev@despammed.com>
References: <200404302009.49576.mlev@despammed.com>
Content-Type: text/plain
Message-Id: <1083382335.1203.2975.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 30 Apr 2004 22:32:16 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-30 at 19:09, Lev Makhlis wrote:
> > +	for (fp = 0xF0000; fp < 0xFFFFF; fp += 16) {
> > +		isa_memcpy_fromio(table_eps, fp, sizeof(*table_eps));
> > +		if (memcmp(table_eps->anchor, "_SM_", 4)!=0)
> > +			continue;
> 
> This is fine for x86 and x86_64, but for ia64 -- don't you need
> to get the SMBIOS entry point from the EFI table?

Sorry, but I am not familiar with how SMBIOS tables work on IA64
architecture, and in fact, the DMI spec says nothing about how it
differs on IA64, that I can see.

Can you please send me a URL with this information? I have access to
some IA64 machines. I will add this code if I have a spec.
--
Michael

