Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291717AbSBXWlV>; Sun, 24 Feb 2002 17:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291711AbSBXWlM>; Sun, 24 Feb 2002 17:41:12 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:64261
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S291712AbSBXWkz>; Sun, 24 Feb 2002 17:40:55 -0500
Date: Sun, 24 Feb 2002 14:27:51 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Paul Mackerras <paulus@samba.org>
cc: Vojtech Pavlik <vojtech@suse.cz>, Troy Benjegerdes <hozer@drgw.net>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
In-Reply-To: <15481.26697.420856.1109@argo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.10.10202241418420.8567-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Obviously this will be a sticking point on the baseclock assumed for each
host; however, the excitement of the commentary tends to validate the
concerns express, but poor word choice.

Given the baseclock is used to setup PIO, and that is the method to issue
and execute the command block, and all other transfers which are not DMA,
it stands to reason, if this becomes messed up so will the transfers.

So my comments in concerns are valid given each host is different and
those capable of determining there internal baseclock which may vary from
the actual PCI slot baseclock, FSB, etc ... will be okay.  The rest of
those which depend on user input of a default safe value which has been
defined in the past and verified by history must remain.

In the past we carried a global since driverfs was not present.

As a point of reference for removal of the pci read/write space to the
host, I strongly suggest that be left alone.  As for the removal of the
settings file, may of the distributions use this as a means to issue
script calls to enable and disable features w/o the use of an additional
application like "hdparm".

Regards,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

