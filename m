Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261859AbSK0KCT>; Wed, 27 Nov 2002 05:02:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261872AbSK0KCT>; Wed, 27 Nov 2002 05:02:19 -0500
Received: from rth.ninka.net ([216.101.162.244]:6576 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S261859AbSK0KCT>;
	Wed, 27 Nov 2002 05:02:19 -0500
Subject: Re: [PATCH][2.4] update ref counts on all allocated pages
From: "David S. Miller" <davem@redhat.com>
To: Matt Porter <porter@cox.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021126170723.A23962@home.com>
References: <20021126170723.A23962@home.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Nov 2002 02:31:31 -0800
Message-Id: <1038393091.14825.0.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-26 at 16:07, Matt Porter wrote:
> The following patch sets the ref count on all pages of an
> allocation.  This allows an allocation with order>0 to be freed
> via individual __free_page() calls within vfree().

If your pci_alloc_consistent implementation is doing something
strang, _it_ should be doing the per-page reference counts.

Don't make every caller eat this overhead.

