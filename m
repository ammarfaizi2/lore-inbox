Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbTFGI0x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 04:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTFGI0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 04:26:53 -0400
Received: from pusa.informat.uv.es ([147.156.10.98]:12252 "EHLO
	pusa.informat.uv.es") by vger.kernel.org with ESMTP id S262720AbTFGI0w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 04:26:52 -0400
Date: Sat, 7 Jun 2003 10:40:25 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: GE traffic statistics (/proc/net/dev)
Message-ID: <20030607084025.GA31639@pusa.informat.uv.es>
References: <20030605142005.GA9292@pusa.informat.uv.es> <1054886644.23214.0.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1054886644.23214.0.camel@rth.ninka.net>
User-Agent: Mutt/1.3.28i
From: uaca@alumni.uv.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 06, 2003 at 01:04:05AM -0700, David S. Miller wrote:
> On Thu, 2003-06-05 at 07:20, uaca@alumni.uv.es wrote:
> > I found very extrange that, for this device, stats on /proc/net/dev updates 
> > each second (more or less), that is, not in sub-second intervals. Again note
> > this only happens for this device and not for other NIC card (Fast-Ethernet 
> > card, e100).
> 
> The chip only periodically sends updated statistics to main
> memory via DMA, the interval can be changed using the
> 'ethtool' utility.

Thanks so much, that explains it

in the other hand, vanilla ethertool-1.7 refused to show -S information and 
crashed the machine using -d

[root@discreto sbin]# ./ethtool -i eth1
driver: tg3
version: 1.2
firmware-version:
bus-info: 00:0b.0

that is a 2.4.20 kernel, the card is an 3Com 906B-T pluged in a 32bit/33Mhz/
5Volt PCI Bus.

I have reported this to the gkernel project on sourceforge

	Ulisses

                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociación Valenciana de Usuarios de Linux		<---
 
