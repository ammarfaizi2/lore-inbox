Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265750AbUADQZl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 11:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265751AbUADQZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 11:25:41 -0500
Received: from mx1.redhat.com ([66.187.233.31]:53717 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265750AbUADQZk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 11:25:40 -0500
Date: Sun, 4 Jan 2004 16:25:16 +0000
From: Dave Jones <davej@redhat.com>
To: Rob Love <rml@ximian.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, szepe@pinerecords.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Pentium M config option for 2.6
Message-ID: <20040104162516.GB31585@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Rob Love <rml@ximian.com>,
	Mikael Pettersson <mikpe@csd.uu.se>, szepe@pinerecords.com,
	akpm@osdl.org, linux-kernel@vger.kernel.org
References: <200401041227.i04CReNI004912@harpo.it.uu.se> <1073228608.2717.39.camel@fur>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073228608.2717.39.camel@fur>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 10:03:28AM -0500, Rob Love wrote:
 > On Sun, 2004-01-04 at 07:27, Mikael Pettersson wrote:
 > > And since P-M doesn't do SMP, does cache line size even
 > > matter? There are no locks to protect from ping-ponging.
 > 
 > Cache line size does still come into the picture on UP, albeit not as
 > much as with SMP - but e.g. it still matters to things like device
 > drivers doing DMA.

Regardless, Tomas's patch changed CONFIG_X86_L1_CACHE_SHIFT for
that CPU, and CONFIG_X86_L1_CACHE_SHIFT shouldn't affect this.
The cacheline size is determined at boottime using the code in
pcibios_init() and set using pci_generic_prep_mwi().

The config option is the default that pci_cache_line_size starts at,
but this gets overridden when the CPU type is determined.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
