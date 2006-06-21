Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbWFUWWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbWFUWWz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 18:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbWFUWWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 18:22:55 -0400
Received: from www.osadl.org ([213.239.205.134]:62421 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1030342AbWFUWWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 18:22:54 -0400
Subject: Re: [2.6 patch] drivers/mtd/devices/: remove dead _ecc code
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Adrian Bunk <bunk@stusta.de>
Cc: dwmw2@infradead.org, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060621215840.GP9111@stusta.de>
References: <20060621215840.GP9111@stusta.de>
Content-Type: text/plain
Date: Thu, 22 Jun 2006 00:24:24 +0200
Message-Id: <1150928664.25491.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-21 at 23:58 +0200, Adrian Bunk wrote:
> This patch removes some code that is dead code after the
> "Remove read/write _ecc variants" patch that went into Linus' tree.

Holy cow, are you even remotly knowing what you are doing ? 

Removing the xxx_ecc function pointers from the mtd structs does not
remove the fundamental requirement of ECC for NAND FLASH.

I'm just waiting for the follow up patches which remove nand_ecc and the
reed solomon library.

When you're done with those, please remove NAND support entirely.

> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Debunked-by: Thomas Gleixner <tglx@linutronix.de>



