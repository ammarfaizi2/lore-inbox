Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbTD2W31 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 18:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTD2W30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 18:29:26 -0400
Received: from adsl-68-74-104-142.dsl.klmzmi.ameritech.net ([68.74.104.142]:40712
	"EHLO tabriel.tabris.net") by vger.kernel.org with ESMTP
	id S261405AbTD2W30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 18:29:26 -0400
From: Tabris <tabris@sbcglobal.net>
To: Andre Hedrick <andre@linux-ide.org>
Subject: Re: 2.4.21-rc1-ac2 Promise IDE DMA won't work
Date: Tue, 29 Apr 2003 18:41:37 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
References: <Pine.LNX.4.10.10304291301150.20264-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10304291301150.20264-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304291841.38501.tabris@sbcglobal.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 April 2003 04:15 pm, Andre Hedrick wrote:
> The Promise chipset use a second DMA engine at offset 0x24 respective
> of the channel.  Mixing an ATA and ATAPI on that channel is almost
> impossible to make the corner cases work.  Next, if there us a 48-bit
> ATA plus ATAPI on the channel popping between the two enignes does
> not look sane at all because one has to swithc the location of the
> hwif->sgtable.

Ok... moved the HDDs from the VIA secondary to the PDC primary (tried 
moving both, but it seems that ide=reverse doesn't work), and the 
CD-R/W to the VIA secondary.

good news, regular reads seem to use the DMA engine. bad news, CDDA 
ripping (using cdparanoia) does not.

is this a known issue? (i thought that CDDA ripping had been fixed)

Haven't tested burning yet.

Hope this all helps, and doesn't annoy too much ;)

--
tabris
-
The day advanced as if to light some work of mine; it was morning, 
and lo! now it is evening, and nothing memorable is accomplished.  
		-- H.D. Thoreau

