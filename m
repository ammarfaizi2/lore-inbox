Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267505AbUIWX3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267505AbUIWX3o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 19:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267548AbUIWX3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 19:29:01 -0400
Received: from holomorphy.com ([207.189.100.168]:64986 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267540AbUIWX11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 19:27:27 -0400
Date: Thu, 23 Sep 2004 16:27:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Yasunori Goto <ygoto@us.fujitsu.com>
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Linux Hotplug Memory Support 
	<lhms-devel@lists.sourceforge.net>
Subject: Re: [Patch/RFC]Removing zone and node ID from page->flags[0/3]
Message-ID: <20040923232713.GJ9106@holomorphy.com>
References: <20040923135108.D8CC.YGOTO@us.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040923135108.D8CC.YGOTO@us.fujitsu.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2004 at 03:55:16PM -0700, Yasunori Goto wrote:
> I updated my patches which remove zone and node ID from page->flags.
> Page->flags is 32bit space and 19 bits of them have already been used on
> 2.6.9-rc2-mm2 kernel, and zone and node ID uses 8 bits on 32 archtecture.
> So, remaining bits is only 5 bits. In addition, only 3 bits have remained
> on 2.6.8.1 stock kernel.
> But, my patches make more 8 bits space in page->flags again.
> And kernel can use large number of node and types of zone.
> These patches are for 2.6.9-rc2-mm2. 

Looks relatively innocuous. I wonder if cosmetically we may want
s/struct zone_tbl/struct zone_table/

I like the path compression in the 2-level radix tree.

Thanks.


-- wli
