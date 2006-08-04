Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161229AbWHDOgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161229AbWHDOgx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 10:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161224AbWHDOgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 10:36:53 -0400
Received: from mx.melware.net ([217.91.97.190]:27910 "EHLO mx.melware.net")
	by vger.kernel.org with ESMTP id S1161228AbWHDOgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 10:36:51 -0400
Date: Fri, 4 Aug 2006 16:36:30 +0200 (CEST)
From: Armin Schindler <armin@melware.de>
X-X-Sender: armin@phoenix.one.melware.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eicon: fix define conflict with ptrace
In-Reply-To: <1154639399.23655.129.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0608041634390.9061@phoenix.one.melware.de>
References: <20060803203411.GB6828@martell.zuzino.mipt.ru>
 <1154639399.23655.129.camel@localhost.localdomain>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Aug 2006, Alan Cox wrote:
> Ar Gwe, 2006-08-04 am 00:34 +0400, ysgrifennodd Alexey Dobriyan:
> > * MODE_MASK is unused in eicon driver.
> > * Conflicts with a ptrace stuff on arm.
> > 
> > drivers/isdn/hardware/eicon/divasync.h:259:1: warning: "MODE_MASK" redefined
> > include2/asm/ptrace.h:48:1: warning: this is the location of the previous definition
> > 
> > Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> 
> NAK. You need to fix all the code expecting to use the MODE_MASK with a
> value of 0x00000080

The definitions in drivers/isdn/hardware/eicon/divasync.h are for
Eicon driver only. Since MODE_MASK is not really used in the Eicon/Divas 
driver, the removal from this file is okay.

Armin

