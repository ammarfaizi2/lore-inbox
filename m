Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261851AbUFNEPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUFNEPQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 00:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUFNEPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 00:15:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:58498 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261851AbUFNEPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 00:15:06 -0400
Date: Sun, 13 Jun 2004 21:14:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [1/12] don't dereference netdev->name before register_netdev()
Message-Id: <20040613211416.6b2503c9.akpm@osdl.org>
In-Reply-To: <20040614003331.GP1444@holomorphy.com>
References: <20040614003148.GO1444@holomorphy.com>
	<20040614003331.GP1444@holomorphy.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
>  * Removed dev->name lookups before register_netdev
>  This fixes Debian BTS #234817.
>  http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=234817
> 
>  	From: Shaul Karl <shaulk@actcom.net.il>
>  	To: submit@bugs.debian.org
>  	Subject: Reports about eth%%d at boot
>  	Message-ID: <20040225225611.GA3532@rakefet>
> 
>    The problem is that most reports at boot time about the eth modules
>  use %%d instead of the interface number. For example,
> 
>      eth%%d: NE2000 found at 0x280, using IRQ 5.
>      NE*000 ethercard probe at 0x240: 00 c0 f0 10 eb 56

This generates a storm of rejects against Jeff's current tree.  This patch
fixes more than Jeff's tree does, but in some places does it slightly
differently.

It needs to be split up and generally chewed through.
