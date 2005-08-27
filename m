Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965200AbVH0Ozr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965200AbVH0Ozr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 10:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751621AbVH0Ozq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 10:55:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:21966 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751618AbVH0Ozq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 10:55:46 -0400
From: Andi Kleen <ak@suse.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [patch] IBM HDAPS accelerometer driver, with probing.
Date: Sat, 27 Aug 2005 16:56:25 +0200
User-Agent: KMail/1.8
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
       Mitchell Blank Jr <mitch@sfgoth.com>,
       "David S. Miller" <davem@davemloft.net>, rml@novell.com, akpm@osdl.org
References: <1125094725.18155.120.camel@betsy> <200508270112.50947.dtor_core@ameritech.net> <20050827113525.GA27575@mipter.zuzino.mipt.ru>
In-Reply-To: <20050827113525.GA27575@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508271656.26699.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 August 2005 13:35, Alexey Dobriyan wrote:

> See? The difference is 64 vs 451 bytes.

Disabling unlikely() doesn't make much difference because the compiler
generates the probability internally then and reorders anyways
(that is why many unlikelys are completely useless
because the default heuristics for them are quite good) 

To see a difference you need to compile with -fno-reorder-blocks

-Andi
