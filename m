Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263568AbUD2GYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbUD2GYs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 02:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263589AbUD2GYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 02:24:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:26575 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263568AbUD2GYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 02:24:45 -0400
Date: Wed, 28 Apr 2004 23:22:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: paulus@samba.org, brettspamacct@fastclick.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-Id: <20040428232222.1be25448.akpm@osdl.org>
In-Reply-To: <1083219158.20089.128.camel@gaston>
References: <409021D3.4060305@fastclick.com>
	<20040428170106.122fd94e.akpm@osdl.org>
	<409047E6.5000505@pobox.com>
	<40905127.3000001@fastclick.com>
	<20040428180038.73a38683.akpm@osdl.org>
	<16528.23219.17557.608276@cargo.ozlabs.ibm.com>
	<20040428185342.0f61ed48.akpm@osdl.org>
	<20040428194039.4b1f5d40.akpm@osdl.org>
	<16528.28485.996662.598051@cargo.ozlabs.ibm.com>
	<1083219158.20089.128.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> 
> > The really strange thing is that the behaviour seems to get worse the
> > more RAM you have.  I haven't noticed any problem at all on my laptop
> > with 768MB, only on the G5, which has 2.5GB.  (The laptop is still on
> > 2.6.2-rc3 though, so I will try a newer kernel on it.)
> 
> Your G5 also has a 2Gb IO hole in the middle of zone DMA, it's possible
> that the accounting doesn't work properly.

heh.  It should have zone->spanned_pages - zone->present_pages = 2G.
