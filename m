Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVCHC0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVCHC0b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 21:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVCHCZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 21:25:47 -0500
Received: from fire.osdl.org ([65.172.181.4]:16593 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261932AbVCHCRp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 21:17:45 -0500
Date: Mon, 7 Mar 2005 18:16:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: vandrove@vc.cvut.cz, cw@f00f.org, linux-kernel@vger.kernel.org
Subject: Re: XScale 8250 patches cause malfunction on AMD-8111
Message-Id: <20050307181651.4a87651d.akpm@osdl.org>
In-Reply-To: <20050307213148.B29948@flint.arm.linux.org.uk>
References: <20050307174506.GA9659@vana.vc.cvut.cz>
	<20050307195654.GA9394@vana.vc.cvut.cz>
	<20050307213148.B29948@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> On Mon, Mar 07, 2005 at 08:56:54PM +0100, Petr Vandrovec wrote:
>  > Well, problem is not in bit 6 in IER, but in bit 6 in high divisor byte,
>  > as DLAB is set to one from previous probe.  This simple clear of LCR
>  > register fixes problem with (probably all 16550A) chips being detected
>  > as XScale, and in addition to it it does not switch my 115200Bd serial
>  > line to 7Bd mode (0x4001 divisor) anymore.
> 
>  Good catch, thanks.  I'd preferably like to see Chris Wedgwood test this
>  before applying it - I'm sure it'll fix his problem as well, but I'd
>  like to be sure.

It fixes it on my box.  Thanks, all.
