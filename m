Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932969AbWF2VzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932969AbWF2VzK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:55:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932901AbWF2Vyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:54:50 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:61134
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932967AbWF2VyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:54:06 -0400
Date: Thu, 29 Jun 2006 14:53:19 -0700 (PDT)
Message-Id: <20060629.145319.71091846.davem@davemloft.net>
To: bos@pathscale.com
Cc: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il,
       openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH 38 of 39] IB/ipath - More changes to support InfiniPath
 on PowerPC 970 systems
From: David Miller <davem@davemloft.net>
In-Reply-To: <c22b6c244d5db77f7b1d.1151617289@eng-12.pathscale.com>
References: <patchbomb.1151617251@eng-12.pathscale.com>
	<c22b6c244d5db77f7b1d.1151617289@eng-12.pathscale.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bryan O'Sullivan <bos@pathscale.com>
Date: Thu, 29 Jun 2006 14:41:29 -0700

>  ipath_core-$(CONFIG_X86_64) += ipath_wc_x86_64.o
> +ipath_core-$(CONFIG_PPC64) += ipath_wc_ppc64.o

Again, don't put these kinds of cpu specific functions
into the infiniband driver.  They are potentially globally
useful, not something only Infiniband might want to do.
