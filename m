Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264342AbTDPM2c (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 08:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbTDPM2c 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 08:28:32 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:62658
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264342AbTDPM2b (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 08:28:31 -0400
Subject: Re: Kernels since 2.5.60 upto 2.5.67 freeze when X server
	terminates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Florin Iucha <florin@iucha.net>
Cc: Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       davej@codemonkey.org.uk
In-Reply-To: <20030416004556.GD29143@iucha.net>
References: <20030415133608.A1447@cuculus.switch.gts.cz>
	 <20030415125507.GA29143@iucha.net> <3E9C03DD.3040200@oracle.com>
	 <20030415164435.GA6389@rivenstone.net> <20030415182057.GC29143@iucha.net>
	 <20030415154355.08ef6672.akpm@digeo.com> <20030416004556.GD29143@iucha.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050493328.28591.42.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 16 Apr 2003 12:42:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-16 at 01:45, Florin Iucha wrote:
> On Tue, Apr 15, 2003 at 03:43:55PM -0700, Andrew Morton wrote:
> > florin@iucha.net (Florin Iucha) wrote:
> > >
> > > I think it has to do with the interaction between XFree86 4.3.0 and
> > > the AGP code.
> > 
> > Has anyone tried disabling kernel AGP support and retesting?
> 
> Now that you suggested it, I disabled kernel AGP support and 4.3.0
> (Daniel Stone Debian packages) works fine so far.

Disablign AGP turned off 3D. There is a problem in a lot of the current
DRI drivers where shared IRQs break as sometimes do restarts because
the IRQ is not masked properly in the DRI module on close down. Its
certainly true in the -ac tree (Radeon patch pending, someone apparently
has other patches I need to chase).

Alan

