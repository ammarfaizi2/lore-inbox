Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268229AbUJMB2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268229AbUJMB2x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 21:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268206AbUJMB2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 21:28:53 -0400
Received: from mail.renesas.com ([202.234.163.13]:45487 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S268229AbUJMB2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 21:28:35 -0400
Date: Wed, 13 Oct 2004 10:28:15 +0900 (JST)
Message-Id: <20041013.102815.135501550.takata.hirokazu@renesas.com>
To: jgarzik@pobox.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ""@renesas.com
From: takata.hirokazu@renesas.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mundt <paul.mundt@nokia.com>, Nicolas Pitre <nico@cam.org>,
 takata@linux-m32r.org
Subject: Re: [PATCH 2.6.9-rc4-mm1] [m32r] Fix smc91x driver for m32r
From: Hirokazu Takata <takata.hirokazu@renesas.com>
In-Reply-To: <416BFD79.1010306@pobox.com>
References: <20041012.195043.137811384.takata.hirokazu@renesas.com>
	<416BFD79.1010306@pobox.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

Sorry, I've changed my mind, according to the thread of 
"[PATCH] net: fix smc91x build for sh/ppc" (Oct 12, 2004).
I prefer that set_irq_type() is snipped by CONFIG_ARM, too.

Please throw away this patch and retrieve the previous 
m32r-trivial-fix-of-smc91xh.patch again, 
if the above patch "[PATCH] net: fix smc91x build for sh/ppc" is applied.

Thank you.

From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH 2.6.9-rc4-mm1] [m32r] Fix smc91x driver for m32r
Date: Tue, 12 Oct 2004 11:51:21 -0400
> Hirokazu Takata wrote:
> > Just fix compile error of drivers/net/smc91x.c for m32r.
> > 
> > It seems the previous patch (m32r-trivial-fix-of-smc91xh.patch) is too old. 
> > So I will send a new patch.
> > 
> > Please drop the previous patch
> > ( $ patch -R1 -p1 <m32r-trivial-fix-of-smc91xh.patch )
> > and apply the new one.
> > 
> > 	* drivers/net/smc91x.h:
> > 	- Add set_irq_type() macro to ignore it for m32r.
> > 	- Fix RPC_LSA_DEFAULT and RPC_LSB_DEFAULT for an M3T-M32700UT board.
> > 
> > Thanks.
> > 
> > Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
> 
> Seems OK to me, I'll put it into my netdev queue.
> 
> For net driver patches, please always CC
> * netdev@oss.sgi.com, and
> * jgarzik@pobox.com
> 
> 	Jeff

-- Takata
