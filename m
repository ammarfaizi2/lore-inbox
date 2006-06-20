Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751472AbWFTW45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbWFTW45 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 18:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751476AbWFTW45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 18:56:57 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47073 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751467AbWFTW4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 18:56:55 -0400
Subject: Re: [PATCH] ide: fix revision comparison in ide_in_drive_list
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Kirill Smelkov <kirr@mns.spb.ru>, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
In-Reply-To: <20060620151950.21ad94d6.akpm@osdl.org>
References: <200606201452.33925.kirr@mns.spb.ru>
	 <20060620151950.21ad94d6.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Jun 2006 00:12:02 +0100
Message-Id: <1150845122.15275.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-06-20 am 15:19 -0700, ysgrifennodd Andrew Morton:
> hm.  This seems...  rather serious.  I assume that in most cases, the
> firmware rev which we have in the table (eg "24.09P07") is a full-string
> match for the string which the drive returned.

They are full matches as far as I can see so it should be ok, plus the
DMA blacklist is mostly hardware that went out ten or more years ago.
Even if it did mis-trigger we'd be blacklisting extra firmware revs of
iffy hardware so that isn't do worrying.

Alan

