Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266368AbSLIXwz>; Mon, 9 Dec 2002 18:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266377AbSLIXwz>; Mon, 9 Dec 2002 18:52:55 -0500
Received: from pc1-cwma1-5-cust42.swan.cable.ntl.com ([80.5.120.42]:1726 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266368AbSLIXwy>; Mon, 9 Dec 2002 18:52:54 -0500
Subject: Re: Patch for ide-tape driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L2.0212091456290.2204-300000@ida.rowland.org>
References: <Pine.LNX.4.33L2.0212091456290.2204-300000@ida.rowland.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Dec 2002 00:37:14 +0000
Message-Id: <1039480634.12046.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-09 at 20:03, Alan Stern wrote:
> Attached are patch files for both 2.4.20 and 2.5.50.  Please apply them
> when you have a chance.

2.4.21pre1 has updated IDE core code so it probably wants a bit of a
resync before it can go in. The 2.5.50 one is matching the 2.4.21pre1
IDE core so it shouldnt be too bad.

The one current difference is that 2.5.50 has ->vdma on devices which if
set indicates you should set up as if for DMA but issue PIO commands.
Its used for controllers that support DMA for PIO mode transfers

