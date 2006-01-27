Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbWA0OqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWA0OqQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 09:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWA0OqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 09:46:16 -0500
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:11493 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1751457AbWA0OqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 09:46:15 -0500
Date: Fri, 27 Jan 2006 15:46:02 +0100
From: Andreas Mohr <andim2@users.sourceforge.net>
To: acx100-devel@lists.sourceforge.net
Cc: Johannes Berg <johannes@sipsolutions.net>, Adrian Bunk <bunk@stusta.de>,
       "John W. Linville" <linville@tuxdriver.com>, jgarzik@pobox.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Acx100-devel] Re: [-mm patch] drivers/net/wireless/tiacx/: remove code for WIRELESS_EXT < 18
Message-ID: <20060127144602.GA5447@rhlx01.fht-esslingen.de>
Reply-To: andi@lisas.de
References: <20060122171104.GC10003@stusta.de> <200601271219.24332.vda@ilport.com.ua> <1138362557.5983.26.camel@localhost> <200601271449.49226.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601271449.49226.vda@ilport.com.ua>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 27, 2006 at 02:49:49PM +0200, Denis Vlasenko wrote:
> On Friday 27 January 2006 13:49, Johannes Berg wrote:
> > On Fri, 2006-01-27 at 12:19 +0200, Denis Vlasenko wrote:
> > 
> > > I very much want to get rid of all remaining compat cruft, and
> > > I plan to do it as soon as acx will be present in mainline kernel.
> > 
> > I doubt you'll get it merged with the compat cruft.
> 
> What cruft? This?
> 
> # grep -r WIRELESS_EXT .
> ./pci.c:                ndev->name, WIRELESS_EXT, UTS_RELEASE);
> ./common.c:             "Wireless extension version:\t" STRING(WIRELESS_EXT) "\n"
> ./acx_struct.h:#ifdef WIRELESS_EXT
> ./acx_struct.h:#if WIRELESS_EXT > 15
> ./ioctl.c:      range->we_version_compiled = WIRELESS_EXT;
> 
> I consider this to be a really modest amount of compat code
> which makes driver users happy (that fraction of it which is not
> willing to run -mm).
> 
> However, I would remove even that at Jeff's or Andrew's request,
> or without anyone's request if acx will be merged to Linus tree.

Indeed, I don't think there should be any discussion at all about this,
since it helps users of our currently still external driver
(not too much longer external, I guess and hope) a lot.
Given that we don't have a stable driver ABI (for way too often discussed
very valid and sane reasons) I really, really think we shouldn't shoot
our foot into pieces by then additionally also bitching about *MINIMAL*
amounts of compatibility code required to keep up with those speedily changing
kernel requirements while our driver isn't included yet.

In the future, I'd like to ask people to be a *bit* more tolerant of newish
compatibility cruft. It's not like we're supporting kernel 2.2.x here still,
our driver is at 2.6.10 at a minimum(!), yet you still want to remove even
those few pieces!
This is simply ridiculous (again, as long as our driver isn't merged, which it
should be soon to improve maintenance).

OK, ending this rather fruitless discussion here. I better get back to hacking,
that's more productive.

Andreas Mohr
