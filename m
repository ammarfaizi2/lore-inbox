Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWHNNl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWHNNl0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 09:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWHNNl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 09:41:26 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:11993 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751368AbWHNNlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 09:41:25 -0400
Subject: Re: md mirror / ext3 / dual core performance strange phenomenon?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Erik Slagter <erik@slagter.name>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1155561134.7809.27.camel@skylla.slagter.name>
References: <1155561134.7809.27.camel@skylla.slagter.name>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 14 Aug 2006 15:01:54 +0100
Message-Id: <1155564114.24077.212.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-08-14 am 15:12 +0200, ysgrifennodd Erik Slagter:
> I am really blown away here. It looks like disk access is the bottleneck
> here, but I can't imagine my disks being so slow (at seeking, I guess)
> it should matter that much.

Keith has answered the main question but your assumptions about seeking
are also not neccessarily correct. Disk seek times as opposed to data
rates and density have not materially improved for many years now, nor
for IDE has the rotation speed and thus rotational latency to access
data.

RAID-1 mirroring generally helps performance as it speeds up the rate of
read command completion at the cost of slower writes. Writes are usually
buffered so tend not to impact performance unless you have a lot of I/O.

Alan

