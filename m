Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbTDPORV (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 10:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264376AbTDPORV 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 10:17:21 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:43964 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP id S264371AbTDPORU 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 10:17:20 -0400
Subject: Re: Kernels since 2.5.60 upto 2.5.67 freeze when X server
	terminates
From: Steven Cole <elenstev@mesatop.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Florin Iucha <florin@iucha.net>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davej@codemonkey.org.uk
In-Reply-To: <1050493328.28591.42.camel@dhcp22.swansea.linux.org.uk>
References: <20030415133608.A1447@cuculus.switch.gts.cz>
	 <20030415125507.GA29143@iucha.net> <3E9C03DD.3040200@oracle.com>
	 <20030415164435.GA6389@rivenstone.net> <20030415182057.GC29143@iucha.net>
	 <20030415154355.08ef6672.akpm@digeo.com> <20030416004556.GD29143@iucha.net>
	 <1050493328.28591.42.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Organization: 
Message-Id: <1050503304.19090.30.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 16 Apr 2003 08:28:24 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-16 at 05:42, Alan Cox wrote:
> On Mer, 2003-04-16 at 01:45, Florin Iucha wrote:
> > On Tue, Apr 15, 2003 at 03:43:55PM -0700, Andrew Morton wrote:
> > > florin@iucha.net (Florin Iucha) wrote:
> > > >
> > > > I think it has to do with the interaction between XFree86 4.3.0 and
> > > > the AGP code.
> > > 
> > > Has anyone tried disabling kernel AGP support and retesting?
> > 
> > Now that you suggested it, I disabled kernel AGP support and 4.3.0
> > (Daniel Stone Debian packages) works fine so far.
> 
> Disablign AGP turned off 3D. There is a problem in a lot of the current
> DRI drivers where shared IRQs break as sometimes do restarts because
> the IRQ is not masked properly in the DRI module on close down. Its
> certainly true in the -ac tree (Radeon patch pending, someone apparently
> has other patches I need to chase).
> 
> Alan
 
I tried 2.5.67-ac1 with AGP and no CONFIG_DRM, with Intel 82810E DC-133
CGC [Chipset Graphics Controller]. With that configuration, I saw the
freeze once (not easily repeatable) on _starting_ the X server (init 5)
after a successful termination of the X server with /sbin/init 3.  The
freeze is 100% repeatable when selecting "Log Out" from KDE or Gnome
after X was started with /sbin/init 5.  If X is started with "startx",
"Log Out" always successfully terminates the X server with no freeze.

This is with RedHat 9.

Steven    

