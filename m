Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVA1O3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVA1O3S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 09:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbVA1O2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 09:28:44 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:53835 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261413AbVA1O2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 09:28:23 -0500
Date: Fri, 28 Jan 2005 14:27:51 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andi Kleen <ak@suse.de>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [PATCH] Add CONFIG_X86_APIC_OFF for i386/UP
In-Reply-To: <20050128133927.GC6703@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0501281421410.7109@goblin.wat.veritas.com>
References: <20050128133927.GC6703@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005, Andi Kleen wrote:
> 
> This patch adds a new CONFIG_X86_APIC_OFF option. This is useful
> for distribution UP kernels who should run with local APIC off by
> default (because older machines often have broken mptables etc.).
> 
> But there are a few machines who don't boot with apic off so there
> needs to be an command line option to enable it.
> 
> When X86_APIC_OFF is set the APIC code is compiled in, but is 
> only enabled when "apic" or "lapic" is specified on the command line
> (or a DMI scanner force enables it).

I'm confused!  Why do we need X86_APIC_OFF config option (but code
compiled in), with boot options "apic" or "lapic" to enable it,
when we already have the code compiled in, with boot options
"noapic" or "nolapic" to disable it?

Hugh
