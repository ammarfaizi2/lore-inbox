Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbWA0MvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbWA0MvR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 07:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbWA0MvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 07:51:17 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:26781 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S965007AbWA0MvQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 07:51:16 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [-mm patch] drivers/net/wireless/tiacx/: remove code for WIRELESS_EXT < 18
Date: Fri, 27 Jan 2006 14:49:49 +0200
User-Agent: KMail/1.8.2
Cc: Adrian Bunk <bunk@stusta.de>, acx100-devel@lists.sourceforge.net,
       "John W. Linville" <linville@tuxdriver.com>, jgarzik@pobox.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20060122171104.GC10003@stusta.de> <200601271219.24332.vda@ilport.com.ua> <1138362557.5983.26.camel@localhost>
In-Reply-To: <1138362557.5983.26.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601271449.49226.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 January 2006 13:49, Johannes Berg wrote:
> On Fri, 2006-01-27 at 12:19 +0200, Denis Vlasenko wrote:
> 
> > I very much want to get rid of all remaining compat cruft, and
> > I plan to do it as soon as acx will be present in mainline kernel.
> 
> I doubt you'll get it merged with the compat cruft.

What cruft? This?

# grep -r WIRELESS_EXT .
./pci.c:                ndev->name, WIRELESS_EXT, UTS_RELEASE);
./common.c:             "Wireless extension version:\t" STRING(WIRELESS_EXT) "\n"
./acx_struct.h:#ifdef WIRELESS_EXT
./acx_struct.h:#if WIRELESS_EXT > 15
./ioctl.c:      range->we_version_compiled = WIRELESS_EXT;

I consider this to be a really modest amount of compat code
which makes driver users happy (that fraction of it which is not
willing to run -mm).

However, I would remove even that at Jeff's or Andrew's request,
or without anyone's request if acx will be merged to Linus tree.
--
vda
