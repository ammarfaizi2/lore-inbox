Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965238AbWHWWDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965238AbWHWWDO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 18:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965237AbWHWWDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 18:03:14 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:20169
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965229AbWHWWDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 18:03:13 -0400
Date: Wed, 23 Aug 2006 15:03:14 -0700 (PDT)
Message-Id: <20060823.150314.41637066.davem@davemloft.net>
To: linas@austin.ibm.com
Cc: arnd@arndb.de, benh@kernel.crashing.org, netdev@vger.kernel.org,
       jklewis@us.ibm.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/6]: powerpc/cell spidernet low watermark patch.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060823213642.GG4401@austin.ibm.com>
References: <1156055509.5803.77.camel@localhost.localdomain>
	<200608201203.15645.arnd@arndb.de>
	<20060823213642.GG4401@austin.ibm.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: linas@austin.ibm.com (Linas Vepstas)
Date: Wed, 23 Aug 2006 16:36:42 -0500

> I could create a searate patch to change struct descr {} to split 
> the u32 into several u8's; there's a dozen spots that get touched.
> 
> Alternatel, I could do a cheesy cast to char[4] and access that way.
> Opinions?

The most portable scheme would be a "u32/u8[4]" union with
appropriate endianness checks when determining which byte
to access in the u8[] view.
