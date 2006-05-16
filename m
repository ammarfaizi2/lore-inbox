Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbWEPMNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWEPMNo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 08:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751783AbWEPMNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 08:13:44 -0400
Received: from canuck.infradead.org ([205.233.218.70]:63697 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1750937AbWEPMNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 08:13:44 -0400
Subject: Re: 2.6.17-rc4-mm1: no help text for MTD_NAND_CS553
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
In-Reply-To: <20060516102554.GL6931@stusta.de>
References: <20060515005637.00b54560.akpm@osdl.org>
	 <20060516102554.GL6931@stusta.de>
Content-Type: text/plain
Date: Tue, 16 May 2006 13:13:21 +0100
Message-Id: <1147781601.27870.17.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-16 at 12:25 +0200, Adrian Bunk wrote:
> This patch adds an MTD_NAND_CS553 option without a help text.
> 
> Please add at least a small help text.

Done; thanks.

config MTD_NAND_CS553X
	tristate "NAND support for CS5535/CS5536 (AMD Geode companion chip)"
	depends on MTD_NAND && X86_PC && PCI
	help
	  The CS553x companion chips for the AMD Geode processor
	  include NAND flash controllers with built-in hardware ECC
	  capabilities; enabling this option will allow you to use
	  these. The driver will check the MSRs to verify that the
	  controller is enabled for NAND, and currently requires that
	  the controller be in MMIO mode.

	  If you say "m", the module will be called "cs553x_nand.ko".
-- 
dwmw2

