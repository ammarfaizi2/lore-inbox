Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWHCU7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWHCU7K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 16:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWHCU7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 16:59:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60132 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751359AbWHCU7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 16:59:08 -0400
Date: Thu, 3 Aug 2006 13:59:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Armin Schindler <mac@melware.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eicon: fix define conflict with ptrace
Message-Id: <20060803135900.0fc41ac5.akpm@osdl.org>
In-Reply-To: <1154639399.23655.129.camel@localhost.localdomain>
References: <20060803203411.GB6828@martell.zuzino.mipt.ru>
	<1154639399.23655.129.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Aug 2006 22:09:59 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

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

There isn't any (under drivers/isdn, anyway).

I assume Alexey already checked that, but forgot to tell us.

Alexey, your changelogging often tends to be too terse.
