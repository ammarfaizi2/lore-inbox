Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTKEQ1B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 11:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262973AbTKEQ1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 11:27:01 -0500
Received: from dp.samba.org ([66.70.73.150]:27615 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262942AbTKEQ07 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 11:26:59 -0500
Date: Thu, 6 Nov 2003 03:23:31 +1100
From: Anton Blanchard <anton@samba.org>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Jes Sorensen <jes@trained-monkey.org>,
       Jamie Wellnitz <Jamie.Wellnitz@emulex.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: virt_to_page/pci_map_page vs. pci_map_single
Message-ID: <20031105162331.GA19104@krispykreme>
References: <1067885332.2076.13.camel@mulgrave> <yq0znfcjwh1.fsf@trained-monkey.org> <1067964220.1792.106.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067964220.1792.106.camel@mulgrave>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I really don't see what's to be gained by doing this.  map_page is for
> mapping one page or a fragment of it.  It's designed for small zero copy
> stuff, like networking.  To get it to map more than one page, really we
> should pass in an array of struct pages.

As an aside it would be nice if networking used the map_sg infrastructure
for zero copy. Some architectures need to do things to make the DMA
mapping visible to IO and at the moment we do it for each map_page.

Anton
