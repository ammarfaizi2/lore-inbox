Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264264AbTCXQQX>; Mon, 24 Mar 2003 11:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264267AbTCXQQX>; Mon, 24 Mar 2003 11:16:23 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:22442
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264264AbTCXQQW>; Mon, 24 Mar 2003 11:16:22 -0500
Subject: Re: ide: indeed, using list_for_each_entry_safe removes endless
	looping / hang [Was: Re: 2.5.65-ac2 -- hda/ide trouble on ICH4]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexander Atanasov <alex@ssi.bg>
Cc: linux@brodo.de, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl
In-Reply-To: <20030324180125.2606b046.alex@ssi.bg>
References: <Pine.LNX.4.21.0303241129420.855-100000@mars.zaxl.net>
	 <1048514373.25136.4.camel@irongate.swansea.linux.org.uk>
	 <20030324180125.2606b046.alex@ssi.bg>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048527607.25655.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Mar 2003 17:40:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-24 at 16:01, Alexander Atanasov wrote:
> 	I don't understand, what's the difference and how the list is lost?
> ata_unused used to hold all drives that were not claimed by any driver,
> now idedefault_driver claims all that drives, all drives go in the .list

ata_unused -> unattached device slots, new hotplug discoveries
idedefault_driver -> attached/known devices with no driver
other list -> driven by that driver

> The bug is there,  and waiting to explode, keeping both lists would mean to 
> add one more  list head  in ide_drive_t,  is that the fix you want?

I don't see where stuff is ending up on both lists yet. I've not had time to look
hard at it though

