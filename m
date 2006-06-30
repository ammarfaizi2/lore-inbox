Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbWF3TTi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWF3TTi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 15:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWF3TTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 15:19:38 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35738 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932171AbWF3TTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 15:19:37 -0400
Date: Fri, 30 Jun 2006 15:19:14 -0400
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alessio Sangalli <alesan@manoweb.com>, Andrew Morton <akpm@osdl.org>,
       alan@lxorguk.ukuu.org.uk, penberg@cs.Helsinki.FI,
       linux-kernel@vger.kernel.org, ink@jurassic.park.msu.ru,
       dtor_core@ameritech.net
Subject: Re: [PATCH] cardbus: revert IO window limit
Message-ID: <20060630191914.GP32729@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Alessio Sangalli <alesan@manoweb.com>,
	Andrew Morton <akpm@osdl.org>, alan@lxorguk.ukuu.org.uk,
	penberg@cs.Helsinki.FI, linux-kernel@vger.kernel.org,
	ink@jurassic.park.msu.ru, dtor_core@ameritech.net
References: <Pine.LNX.4.58.0606220947250.15059@sbz-30.cs.Helsinki.FI> <20060622001104.9e42fc54.akpm@osdl.org> <1150976158.15275.148.camel@localhost.localdomain> <Pine.LNX.4.64.0606220917080.5498@g5.osdl.org> <20060622093606.2b3b1eb7.akpm@osdl.org> <Pine.LNX.4.64.0606221005410.5498@g5.osdl.org> <449B0B3C.2020904@manoweb.com> <Pine.LNX.4.64.0606301200400.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606301200400.12404@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2006 at 12:10:32PM -0700, Linus Torvalds wrote:
 > 
 > 
 > On Thu, 22 Jun 2006, Alessio Sangalli wrote:
 > > 
 > > # /sbin/lspci -vvx
 > > 00:00.0 Host bridge: Intel Corp. 82440MX Host Bridge (rev 01)
 > >         Subsystem: Compaq Computer Corporation: Unknown device 000d
 > >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
 > >         Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort+ >SERR- <PERR-
 > >         Latency: 64
 > > 00: 86 80 94 71 06 00 00 22 01 00 00 06 00 40 80 00
 > > 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 > > 20: 00 00 00 00 00 00 00 00 00 00 00 00 11 0e 0d 00
 > > 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 > 
 > Ok. We don't actually have any quirks at all for the 82440MX, and that's 
 > almost certainly _not_ because it doesn't do something strange (all Intel 
 > host bridges have magic IO ranges), but simply because we haven't hit it 
 > yet.
 > 
 > And I can't find the docs for the PCI config space for that dang thing.
 > 
 > I bet that there's some magic SMBus IO-range that the 440MX decodes using 
 > a special magic config setting.
 > 
 > Has anybody found the config space docs for the 82440MX? 

http://www.codemonkey.org.uk/cruft/440/
There's an assortment of docs for the other flavour Intel PCIsets from
that era in the same dir.

		Dave

-- 
http://www.codemonkey.org.uk
