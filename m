Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291026AbSBLNgB>; Tue, 12 Feb 2002 08:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291043AbSBLNfw>; Tue, 12 Feb 2002 08:35:52 -0500
Received: from grisu.bik-gmbh.de ([194.233.237.82]:30213 "EHLO
	grisu.bik-gmbh.de") by vger.kernel.org with ESMTP
	id <S291026AbSBLNfj>; Tue, 12 Feb 2002 08:35:39 -0500
Date: Tue, 12 Feb 2002 14:36:19 +0100
From: Florian Hars <florian@hars.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unknown Southbridge (was: Disk-I/O and kupdated@99.9% system (2.4.18-pre9))
Message-ID: <20020212133619.GA324@bik-gmbh.de>
In-Reply-To: <20020208164250.GA321@bik-gmbh.de> <20020212102005.GB365@bik-gmbh.de> <20020212112349.A1691@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020212112349.A1691@suse.cz>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

begin  Vojtech Pavlik quote:
> On Tue, Feb 12, 2002 at 11:20:05AM +0100, Florian Hars wrote:
> > I use a Gigabyte GA-7VTXE with a VIA KT266A chipset and a Southbridge
> > called VT8233A, which does not look like one of the "FUTURE_BRIDGES"
> 
> 2.5.2 (and later, and maybe some earlier versions as well) have support
> for this chipset. You can copy over the via82cxxx.c and ide-timing.h to
> your kernel and it should work.

Not really:

via82cxxx.c: In function `ide_init_via82cxxx':
via82cxxx.c:548: structure has no member named `highmem'
make[4]: *** [via82cxxx.o] Fehler 1

I had to remove the offending line (it isn't there in the 2.4 version
of the file), and of course add the PCI ID of the SouthBridge in
the appropriate places. Now the system boots and hdparm says that
dma is activated. So lets see how well it behaves...

Yours, Florian Hars.
