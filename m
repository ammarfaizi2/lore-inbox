Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbVKMDnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbVKMDnm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 22:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbVKMDnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 22:43:42 -0500
Received: from ns1.suse.de ([195.135.220.2]:24254 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751265AbVKMDnl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 22:43:41 -0500
From: Andi Kleen <ak@suse.de>
To: jmerkey <jmerkey@utah-nac.org>
Subject: Re: [PATCH 0/39] NLKD - Novell Linux Kernel Debugger
Date: Sun, 13 Nov 2005 04:44:44 +0100
User-Agent: KMail/1.8.2
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Jan Beulich <JBeulich@novell.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
References: <43720DAE.76F0.0078.0@novell.com> <p73u0eh4als.fsf@verdi.suse.de> <4376AAC1.5060503@utah-nac.org>
In-Reply-To: <4376AAC1.5060503@utah-nac.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511130444.45468.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 November 2005 03:53, jmerkey wrote:

> Yes. This is the way to go. Use kdb as a base and instrument an 
> alternate debugger interface. You need to also find a good way to
> allow GDB to work properly with alternate debuggers. At present, the 
> code in traps.c is mutually exclusive since embedded int3
> breakpoints trigger in the kernel for gbd. This is busted.


I don't think we'll support stacking multiple kernel debuggers (except
for special cases like kprobes+another debugger). It's complicated
and probably not worth it.

-Andi

