Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbTFLXe4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 19:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265061AbTFLXe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 19:34:56 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:39160 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S265060AbTFLXev
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 19:34:51 -0400
Subject: Re: [PATCH] udev enhancements to use kernel event queue
From: Robert Love <rml@tech9.net>
To: Paul Mackerras <paulus@samba.org>
Cc: Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@digeo.com>, sdake@mvista.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <16105.3943.510055.309447@nanango.paulus.ozlabs.org>
References: <1055460564.662.339.camel@localhost>
	 <Pine.LNX.4.44.0306121629590.11379-100000@cherise>
	 <16105.3943.510055.309447@nanango.paulus.ozlabs.org>
Content-Type: text/plain
Message-Id: <1055461816.662.350.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 (1.4.0-2) 
Date: 12 Jun 2003 16:50:16 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-06-12 at 16:40, Paul Mackerras wrote:

> BZZZT.  If another CPU is also doing atomic_inc_and_read you could end
> up with both calls returning the same value.

That is what I thought. Damn.

> You can't do atomic_inc_and_read on 386.  You can on cpus that have
> cmpxchg (e.g. later x86).  You can also on machines with load-locked
> and store-conditional instructions (alpha, ppc, probably most other
> RISCs).

So this is doable on everything but old i386 chips... hrm.

	Robert Love

