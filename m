Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261919AbTGFK4a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 06:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261874AbTGFK4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 06:56:30 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:8576 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S261919AbTGFK43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 06:56:29 -0400
Date: Sun, 6 Jul 2003 13:10:15 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ryan Mack <lists@mackman.net>,
       Markus Plail <linux-kernel@gitteundmarkus.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21 ServerWorks DMA Bugs
Message-ID: <20030706111015.GA303@louise.pinerecords.com>
References: <Pine.LNX.4.53.0307042325430.3837@mackman.net> <87fzllh21i.fsf@gitteundmarkus.de> <Pine.LNX.4.53.0307050956060.2029@mackman.net> <1057477237.700.6.camel@dhcp22.swansea.linux.org.uk> <20030706090656.GA4739@louise.pinerecords.com> <1057482631.705.15.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057482631.705.15.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [alan@lxorguk.ukuu.org.uk]
> 
> On Sul, 2003-07-06 at 10:06, Tomas Szepe wrote:
> > It doesn't all right. :)
> > 
> > On a G3 Compaq Proliant, all drives come up in PIO by default;
> > DMA needs to be enabled by "/usr/sbin/hdparm -d1 -X69 /dev/hdX".
> 
> This is because your compaq BIOS decided to set it up this way.

Also note that when the '-X' switch is omitted (i.e. one only issues
"/usr/sbin/hdparm -d1 /dev/hdX"), the driver sets up a mode that doesn't
work and then quickly falls back to PIO.
