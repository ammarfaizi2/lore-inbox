Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965081AbWEYH7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbWEYH7f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 03:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965079AbWEYH7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 03:59:35 -0400
Received: from gate.crashing.org ([63.228.1.57]:2466 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S965077AbWEYH7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 03:59:34 -0400
Subject: Re: [PATCH 3/4] myri10ge - Driver core
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brice Goglin <brice@myri.com>
Cc: Anton Blanchard <anton@samba.org>, netdev@vger.kernel.org,
       gallatin@myri.com, linux-kernel@vger.kernel.org
In-Reply-To: <4474138C.2050705@myri.com>
References: <20060517220218.GA13411@myri.com>
	 <20060517220608.GD13411@myri.com> <20060523153928.GB5938@krispykreme>
	 <4474138C.2050705@myri.com>
Content-Type: text/plain
Date: Thu, 25 May 2006 17:59:02 +1000
Message-Id: <1148543942.13249.268.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 10:04 +0200, Brice Goglin wrote:

> I am not sure what you mean.
> The only ppc64 with PCI-E that we have seen so far (a G5) couldn't do
> write combining according to Apple.

That is not 100% true.... I don't know what apple had in mind. It also
depends in what slot you are.

Do you have ways to measure the difference ?

Try doing __ioremap(mgp->iomem_base, mgp->board_span, _PAGE_NO_CACHE);
instead of using the normal ioremap for #ifdef powerpc and tell us if it
makes a difference.

Ben.

