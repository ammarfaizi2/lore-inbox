Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965554AbWIRIO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965554AbWIRIO0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 04:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965555AbWIRIO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 04:14:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60869 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965554AbWIRIOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 04:14:25 -0400
Subject: Re: [-mm patch 2/3] AVR32 MTD: Unlock flash if necessary (try 2)
From: David Woodhouse <dwmw2@infradead.org>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060918101224.12508491@cad-250-152.norway.atmel.com>
References: <20060915163102.73bf171d@cad-250-152.norway.atmel.com>
	 <20060915163554.4f326bf6@cad-250-152.norway.atmel.com>
	 <20060915163711.10d19763@cad-250-152.norway.atmel.com>
	 <1158334346.24527.94.camel@pmac.infradead.org>
	 <20060918101224.12508491@cad-250-152.norway.atmel.com>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 09:14:20 +0100
Message-Id: <1158567260.24527.313.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-18 at 10:12 +0200, Haavard Skinnemoen wrote:
> On Fri, 15 Sep 2006 16:32:26 +0100
> David Woodhouse <dwmw2@infradead.org> wrote:
> 
> > On Fri, 2006-09-15 at 16:37 +0200, Haavard Skinnemoen wrote:
> > > If a cfi_cmdset_0002 fixup installs an unlock() operation, use it
> > > to unlock the whole flash after the erase regions have been set up.
> > 
> > There are cmdset_0001 chips which have this affliction too. I was
> > thinking of having a flag MTD_STUPID_LOCK which you set when you
> > determine that it's one of these chips, then add_mtd_device() can do
> > the unlocking... or add_mtd_partitions() can do it but _only_ for
> > writable partitions.
> 
> Ok, so how about something like this? Which other chips should be marked?

Looks good; thanks. There's some Intel chips which need to be so marked
but I'll let the Intel folks deal with that.

I'll apply it to my git tree, but only _after_ Linus has pulled from it
as requested a couple of days ago -- I think this should wait for 2.6.19
rather than being slipped in at the last moment.

-- 
dwmw2

