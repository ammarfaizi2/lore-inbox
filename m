Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267180AbTBLNlT>; Wed, 12 Feb 2003 08:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267178AbTBLNlL>; Wed, 12 Feb 2003 08:41:11 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:31117 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267174AbTBLNjf>;
	Wed, 12 Feb 2003 08:39:35 -0500
Date: Wed, 12 Feb 2003 13:44:30 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: James McKenzie <james@fishsoup.dhs.org>,
       Christian Gennerat <christian.gennerat@polytechnique.org>,
       Martin Lucina <mato@kotelna.sk>,
       Paul Bristow <paul.bristow@technologist.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] rename all symbols in drivers/net/irda/donauboe.c
Message-ID: <20030212134430.GB3770@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>,
	James McKenzie <james@fishsoup.dhs.org>,
	Christian Gennerat <christian.gennerat@polytechnique.org>,
	Martin Lucina <mato@kotelna.sk>,
	Paul Bristow <paul.bristow@technologist.com>,
	linux-kernel@vger.kernel.org
References: <20030212132313.GB22472@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212132313.GB22472@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 02:23:14PM +0100, J?rn Engel wrote:

 > When compiling a kernel with both CONFIG_TOSHIBA_OLD and
 > CONFIG_TOSHIBA_FIR set to yes, the two drivers both define the same
 > symbols and the build breaks.
 > 
 > While this is an unusual configuration, it might make sense sometimes
 > to compile a kernel that will boot on several machines.

But with both drivers built into the kernel, it'll always default
to the first one that gets initialised. There's a common
PCI_DEVICE_ID_FIR701 in the pci_device_id tables of both drivers.

It sounds like these should be mutually exclusive when built-in.
If you need a configuration with both, use modules.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
