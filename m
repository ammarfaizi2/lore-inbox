Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266631AbTGFIwi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 04:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266644AbTGFIwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 04:52:37 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:16352 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S266631AbTGFIwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 04:52:36 -0400
Date: Sun, 6 Jul 2003 11:06:56 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ryan Mack <lists@mackman.net>,
       Markus Plail <linux-kernel@gitteundmarkus.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21 ServerWorks DMA Bugs
Message-ID: <20030706090656.GA4739@louise.pinerecords.com>
References: <Pine.LNX.4.53.0307042325430.3837@mackman.net> <87fzllh21i.fsf@gitteundmarkus.de> <Pine.LNX.4.53.0307050956060.2029@mackman.net> <1057477237.700.6.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057477237.700.6.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [alan@lxorguk.ukuu.org.uk]
> 
> > Also, does anybody know what the status of the failure to recognize higher 
> > UDMA modes on the CSB5 chipset?  Is there a working patch out there?
> 
> CSB5 UDMA works properly to all my knowledge

It doesn't all right. :)

On a G3 Compaq Proliant, all drives come up in PIO by default;
DMA needs to be enabled by "/usr/sbin/hdparm -d1 -X69 /dev/hdX".

# /sbin/lspci| grep IDE
00:0f.1 IDE interface: ServerWorks CSB5 IDE Controller (rev 93)

# hdparm -Iv /dev/hdc| grep -ai model
        Model Number:       WDC WD1200JB-00CRA1                     

-- 
Tomas Szepe <szepe@pinerecords.com>
