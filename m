Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262503AbVHDMJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262503AbVHDMJH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 08:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVHDMJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 08:09:06 -0400
Received: from cantor2.suse.de ([195.135.220.15]:49347 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S262503AbVHDMIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 08:08:52 -0400
From: Andreas Schwab <schwab@suse.de>
To: Olof Johansson <olof@lixom.net>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linuxppc64-dev@ozlabs.org,
       paulus@samba.org, anton@samba.org, miltonm@bga.com
Subject: Re: [PATCH] PPC64: Fix UP kernel build
References: <20050804013010.GA10556@austin.ibm.com>
X-Yow: If Robert Di Niro assassinates Walter Slezak, will
 Jodie Foster marry Bonzo??
Date: Thu, 04 Aug 2005 14:08:43 +0200
In-Reply-To: <20050804013010.GA10556@austin.ibm.com> (Olof Johansson's message
	of "Wed, 3 Aug 2005 20:30:10 -0500")
Message-ID: <jeacjxykdw.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olof Johansson <olof@lixom.net> writes:

> Index: 2.6/arch/ppc64/kernel/machine_kexec.c
> ===================================================================
> --- 2.6.orig/arch/ppc64/kernel/machine_kexec.c	2005-08-03 19:53:16.000000000 -0500
> +++ 2.6/arch/ppc64/kernel/machine_kexec.c	2005-08-03 20:39:49.000000000 -0500
> @@ -243,13 +243,17 @@ static void kexec_prepare_cpus(void)
>  
>  static void kexec_prepare_cpus(void)
>  {
> +	extern void smp_release_cpus(void);

Please put this in a header.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
