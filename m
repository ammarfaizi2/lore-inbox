Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265102AbSK1DDv>; Wed, 27 Nov 2002 22:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265111AbSK1DDv>; Wed, 27 Nov 2002 22:03:51 -0500
Received: from rth.ninka.net ([216.101.162.244]:51378 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S265102AbSK1DDv>;
	Wed, 27 Nov 2002 22:03:51 -0500
Subject: Re: [PATCH][2.4] update ref counts on all allocated pages
From: "David S. Miller" <davem@redhat.com>
To: Matt Porter <porter@cox.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20021127082556.A26524@home.com>
References: <20021126170723.A23962@home.com>
	<1038393091.14825.0.camel@rth.ninka.net>  <20021127082556.A26524@home.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Nov 2002 19:33:17 -0800
Message-Id: <1038454397.17075.4.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-27 at 07:25, Matt Porter wrote:
> To clarify then, on an order>0 allocation, it is only valid/defined
> to free the same order of pages.  Is that a true statement?  If so,
> I'll submit a docs patch and adjust our our local implementation.

Yes, this is correct and it's what everyone does.  The exceptions
mess with the page counts themselves, look at the sparc64
pmd/pte dual-page allocations for example.

