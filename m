Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262948AbTDBITy>; Wed, 2 Apr 2003 03:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262949AbTDBITy>; Wed, 2 Apr 2003 03:19:54 -0500
Received: from rth.ninka.net ([216.101.162.244]:25063 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S262948AbTDBITx>;
	Wed, 2 Apr 2003 03:19:53 -0500
Subject: Re: 2.4.21-pre6 and usb-uhci
From: "David S. Miller" <davem@redhat.com>
To: Ben Collins <bcollins@debian.org>
Cc: Miek Gieben <miekg@atoom.net>, linux-kernel@vger.kernel.org
In-Reply-To: <20030402045439.GW28258@phunnypharm.org>
References: <20030401093646.GA11420@atoom.net>
	 <20030402045439.GW28258@phunnypharm.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049272268.21215.0.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 02 Apr 2003 00:31:08 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 2003-04-01 at 20:54, Ben Collins wrote:
> On Tue, Apr 01, 2003 at 11:36:46AM +0200, Miek Gieben wrote:
> > Hello,
> > 
> > [ i'm not subscribed, so please cc me on any follow ups]
> > 
> > with kernel 2.4.21-pre6 my usb mouse stopped working (actually all usb stuff
> > stopped working). It's a logitech optical mouse which worked perfectly under
> > -pre5. I'm using the usb-uhci module.  I get no failures are anything of that
> 
> I get the same problem. This includes a Logitech keyboard, two joysticks
> and a Linksys WUSB11 wlan adapter. None of them show up.

drivers/usb/Makefile is borked, it doesn't link in the USB
host controller drivers when you enable them statically
into the kernel.

-- 
David S. Miller <davem@redhat.com>
