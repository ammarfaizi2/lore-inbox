Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbWIKOkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbWIKOkO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 10:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWIKOkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 10:40:14 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:30187 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751265AbWIKOkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 10:40:12 -0400
Subject: Re: What's in libata-dev.git
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <450568F3.3020005@ru.mvista.com>
References: <20060911132250.GA5178@havoc.gtf.org>
	 <45056627.7030202@ru.mvista.com> <450566A2.1090009@garzik.org>
	 <450568F3.3020005@ru.mvista.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 11 Sep 2006 16:02:54 +0100
Message-Id: <1157986974.23085.147.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-09-11 am 17:47 +0400, ysgrifennodd Sergei Shtylyov:
>     It's not likely I'll be able to try it. But I'm absolutely sure that drive 
> aborted the read commands with the sector count of 0 (i.e. 256 actually). The 
> exact model was IBM DHEA-34331.

Several people reported this problem when we tried 256 years ago in
drivers/ide. You might want to do 256 for SATA Jeff but please don't do
256 for PATA. Reading specs is too hard for some people ;)

Some drives abort the xfer, some just choked.

