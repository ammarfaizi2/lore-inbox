Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263257AbTCZFGT>; Wed, 26 Mar 2003 00:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263279AbTCZFGT>; Wed, 26 Mar 2003 00:06:19 -0500
Received: from [131.215.233.56] ([131.215.233.56]:41226 "EHLO bryanr.org")
	by vger.kernel.org with ESMTP id <S263257AbTCZFGT>;
	Wed, 26 Mar 2003 00:06:19 -0500
Date: Tue, 25 Mar 2003 21:04:49 -0800
From: Bryan Rittmeyer <bryanr@bryanr.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] oprofile + ppc750cx perfmon
Message-ID: <20030326050449.GB32590@bryanr.org>
References: <20030325050900.GA30294@bryanr.org> <20030325085759.GB30294@bryanr.org> <1048585501.581.16.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048585501.581.16.camel@zion.wanadoo.fr>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 25, 2003 at 10:45:02AM +0100, Benjamin Herrenschmidt wrote:
> I also think we could actually be smarter and only
> soft-disable IRQs with a flag in the descriptor, and hard disable
> them if and only if they actually occur while disabled.

yup. minimizing open_pic I/O could be a big win. the fact that
the PIC shows up _way_ ahead of the network driver and stack is
pretty freakish compared to a profile on x86 using io-apic
(the legacy x86 pic has similar but less severe issues as open_pic).

-Bryan
