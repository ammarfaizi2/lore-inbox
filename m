Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261874AbVAaAl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbVAaAl6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 19:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbVAaAl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 19:41:58 -0500
Received: from baythorne.infradead.org ([81.187.226.107]:41919 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261874AbVAaAlx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 19:41:53 -0500
Subject: Re: inter-module-* removal.. small next step
From: David Woodhouse <dwmw2@infradead.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, bunk@stusta.de
In-Reply-To: <20050130180016.GA12987@infradead.org>
References: <20050130180016.GA12987@infradead.org>
Content-Type: text/plain
Date: Mon, 31 Jan 2005 00:41:52 +0000
Message-Id: <1107132112.783.219.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-30 at 18:00 +0000, Arjan van de Ven wrote:
> Hi,
> 
> intermodule is deprecated for quite some time now, and MTD is the sole last
> user in the tree. To shrink the kernel for the people who don't use MTD, and
> to prevent accidental return of more users of this, make the compiling of
> this function conditional on MTD.

Please get the dependencies right -- it's not core MTD code, but the NOR
chip drivers and the old DiskOnChip drivers which use this. 

-- 
dwmw2


