Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbTD2Vly (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 17:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261887AbTD2Vlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 17:41:53 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:53908
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261880AbTD2Vlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 17:41:52 -0400
Subject: Re: 2.4.21-rc1-ac2 Promise IDE DMA won't work
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Tabris <tabris@sbcglobal.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10304291301150.20264-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10304291301150.20264-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051649715.18217.59.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Apr 2003 21:55:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-04-29 at 21:15, Andre Hedrick wrote:
> The Promise chipset use a second DMA engine at offset 0x24 respective of
> the channel.  Mixing an ATA and ATAPI on that channel is almost impossible
> to make the corner cases work.  Next, if there us a 48-bit ATA plus ATAPI
> on the channel popping between the two enignes does not look sane at all
> because one has to swithc the location of the hwif->sgtable.

You can wrap that on the drivers for the disk stuff now but not cleanly for
the other cases. Is there any reason we can't use the ATAPI engine for
everything btw ?

