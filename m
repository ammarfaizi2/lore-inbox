Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTD3AO2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 20:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbTD3AO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 20:14:27 -0400
Received: from main.gmane.org ([80.91.224.249]:63111 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262050AbTD3AOZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 20:14:25 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nicholas Wourms <nwourms@myrealbox.com>
Subject: Re: 2.4.21-rc1-ac2 Promise IDE DMA won't work
Date: Tue, 29 Apr 2003 20:21:39 -0400
Message-ID: <3EAF1713.7000009@myrealbox.com>
References: <Pine.LNX.4.10.10304291301150.20264-100000@master.linux-ide.org> <200304291841.38501.tabris@sbcglobal.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@main.gmane.org
Cc: alan@lxorguk.ukuu.org.uk
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.74.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tabris wrote:
> On Tuesday 29 April 2003 04:15 pm, Andre Hedrick wrote:
> 
>>The Promise chipset use a second DMA engine at offset 0x24 respective
>>of the channel.  Mixing an ATA and ATAPI on that channel is almost
>>impossible to make the corner cases work.  Next, if there us a 48-bit
>>ATA plus ATAPI on the channel popping between the two enignes does
>>not look sane at all because one has to swithc the location of the
>>hwif->sgtable.
> 
> 
> Ok... moved the HDDs from the VIA secondary to the PDC primary (tried 
> moving both, but it seems that ide=reverse doesn't work), and the 
> CD-R/W to the VIA secondary.
> 
> good news, regular reads seem to use the DMA engine. bad news, CDDA 
> ripping (using cdparanoia) does not.
> 
> is this a known issue? (i thought that CDDA ripping had been fixed)
> 

Have you tried Andrew Morton's ide-cd dma patch?  It seems to have 
worked well for me, at least.  A summary of what it does is included at 
the top of the patch.

http://www.zipworld.com.au/~akpm/linux/patches/2.4/2.4.20/ide-akpm.patch

Perhaps Alan might considier it for the -rc2 ac patch?

Cheers,
Nicholas


