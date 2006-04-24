Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750900AbWDXPkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbWDXPkM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 11:40:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbWDXPkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 11:40:12 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:52933 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750900AbWDXPkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 11:40:11 -0400
Subject: Re: How can I prevent MTD to access the end of a flash device ?
From: David Woodhouse <dwmw2@infradead.org>
To: Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc: Nicolas Pitre <nico@cam.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <cda58cb80604231157g58088e0dhb93a91c46deda627@mail.gmail.com>
References: <cda58cb80511070248o6d7a18bex@mail.gmail.com>
	 <cda58cb80511220658n671bc070v@mail.gmail.com>
	 <Pine.LNX.4.64.0511221042560.6022@localhost.localdomain>
	 <cda58cb80604231006x4911598bg6c1e3d62f07d80e7@mail.gmail.com>
	 <Pine.LNX.4.64.0604231323180.3603@localhost.localdomain>
	 <cda58cb80604231157g58088e0dhb93a91c46deda627@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 24 Apr 2006 16:40:30 +0100
Message-Id: <1145893231.16166.340.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-04-23 at 20:57 +0200, Franck Bui-Huu wrote:
> well, mtd_concat_create() functions doesn't use MTD partitions...and
> what's happening if the user needs to use its own partitions based on
> a device resulting of several concatenated flashes? It migth be
> possible to still use your solution and just fix user partitions but
> it really seems easier to fix the MTD size after it the flash has been
> probed.

MTD partitions aren't like block device partitions. You just get a set
of MTD devices which are like a wrapper around the original.

MTD concat is the same. You should be able to partition and concat and
partition and concat on top of each other to your heart's content. If
you so desire.

> Do you think it's possible to change the size of a mtd device rigth
> after probing it ?

Yes, that works too.

-- 
dwmw2

