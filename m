Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264381AbTEaQvg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 12:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264380AbTEaQvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 12:51:36 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:14561
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264386AbTEaQvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 12:51:35 -0400
Subject: Re: Any experience with Promise PDC20376 and SATA RAID?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Andre Hedrick <andre@linux-ide.org>, reid@reidspencer.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <3ED8D709.9060807@gmx.net>
References: <20030528160001.21400.75235.Mailman@listman.rdu-colo.redhat.com>
	 <1054139205.1257.11.camel@bashful.x10sys.com>  <3ED8D709.9060807@gmx.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054397191.27312.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 31 May 2003 17:06:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-05-31 at 17:23, Carl-Daniel Hailfinger wrote:
> Reid Spencer wrote:
> > I think the kernel doesn't know about the device number (105a:3376 =
> > PDC20376) since it isn't in the kernel's drivers/pci/pci.ids file
> > (latest device is 7275 PDC20277)and it doesn't recognize the device when
> > it processes the IDE devices at boot up. All I get is:

20376 is not currently supported. Promise do have their own GPL driver
which handles this device as if it were a scsi adapter. In the same way
that Jeff Garzik has realised we need to go this path for smart SATA 
stuff so have promise.

Figuring out what to do about all this for 2.4 is on my pending pile
still - do we merge a minimal support into base 2.4.x as FreeBSD did
with their support or do we merge a scsi layer driver that can actually
make use of the command queueing (not neccessarily tagged) on the device
and/or the hardware XOR engine.

