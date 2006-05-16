Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbWEPNEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWEPNEv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 09:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbWEPNEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 09:04:51 -0400
Received: from canuck.infradead.org ([205.233.218.70]:10392 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751043AbWEPNEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 09:04:50 -0400
Subject: Re: [-mm patch] make drivers/mtd/nand/cs553x_nand.c:cs553x_init()
	static
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
In-Reply-To: <20060516123750.GS6931@stusta.de>
References: <20060515005637.00b54560.akpm@osdl.org>
	 <20060516123750.GS6931@stusta.de>
Content-Type: text/plain
Date: Tue, 16 May 2006 14:04:19 +0100
Message-Id: <1147784659.27870.43.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-05-16 at 14:37 +0200, Adrian Bunk wrote:
> This patch makes the needlessly global cs553x_init() static.

NAK. That problem was inherited from another board driver which was
copied and modified. And that driver inherited it in turn... let's not
piss about with them one at a time; let's just fix them _all_ at once,
instead. And let's remove the bizarre use of '#ifdef MODULE' around the
cleanup functions while we're at it.

http://git.infradead.org/?p=mtd-2.6.git;a=commitdiff;h=cead4dbc03ba6eb2e35bac04439b76a0cc2286ce

-- 
dwmw2

