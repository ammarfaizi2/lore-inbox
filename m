Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268400AbUHXVyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268400AbUHXVyM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 17:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268353AbUHXVxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 17:53:38 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:3740 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268367AbUHXVtX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 17:49:23 -0400
Message-ID: <41b516cb0408241449464de5a7@mail.gmail.com>
Date: Tue, 24 Aug 2004 14:49:22 -0700
From: Chris Leech <chris.leech@gmail.com>
Reply-To: Chris Leech <chris.leech@gmail.com>
To: Roland Dreier <roland@topspin.com>
Subject: Re: [PATCH] [broken?] Add MSI support to e1000
Cc: "Nguyen, Tom L" <tom.l.nguyen@intel.com>, cramerj <cramerj@intel.com>,
       "Ronciak, John" <john.ronciak@intel.com>,
       "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <52u0utvka4.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <C7AB9DA4D0B1F344BF2489FA165E50240619D5A0@orsmsx404.amr.corp.intel.com> <52u0utvka4.fsf@topspin.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2004 10:25:39 -0700, Roland Dreier 
> Based on the e1000 documentation I have, the only thing required for
> the e1000 to use MSI is to set the MSI enable bit in the PCI header.
> Of course there may be some e1000 erratum involving MSI but I have not
> been able to find any indication that this is the case.

Unfortunately, there are issues with current PRO/1000 devices that
make MSI unusable.  Other testing has show similar results to what you
are reporting, under low load a few interrupts can be observed to work
but the part stops working when stressed.  This is why MSI has not
already been enabled in the e1000 driver.

-Chris Leech
