Return-Path: <linux-kernel-owner+w=401wt.eu-S1753578AbWLRJKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578AbWLRJKx (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 04:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753579AbWLRJKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 04:10:53 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:39118
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753577AbWLRJKw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 04:10:52 -0500
Date: Mon, 18 Dec 2006 01:10:50 -0800 (PST)
Message-Id: <20061218.011050.92570987.davem@davemloft.net>
To: dwmw2@infradead.org
Cc: torvalds@osdl.org, johnpol@2ka.mipt.ru, nickpiggin@yahoo.com.au,
       rmk+lkml@arm.linux.org.uk, dhowells@redhat.com, akpm@osdl.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/2] WorkStruct: Add assign_bits() to give an
 atomic-bitops safe assignment
From: David Miller <davem@davemloft.net>
In-Reply-To: <1166432184.25827.8.camel@pmac.infradead.org>
References: <457F606B.70805@yahoo.com.au>
	<Pine.LNX.4.64.0612151437130.3849@woody.osdl.org>
	<1166432184.25827.8.camel@pmac.infradead.org>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Woodhouse <dwmw2@infradead.org>
Date: Mon, 18 Dec 2006 08:56:24 +0000

> On Fri, 2006-12-15 at 14:45 -0800, Linus Torvalds wrote:
> > This uses "atomic_long_t" for the workstruct "data" field, which shares 
> > the per-cpu pointer and the workstruct flag bits in one field.
> 
> This fixes drivers/connector/connector.c to cope...
> 
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>

I have a fix for this already in my net-2.6 tree and I'll push it
later tonight.
