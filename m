Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291042AbSBLNil>; Tue, 12 Feb 2002 08:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291043AbSBLNif>; Tue, 12 Feb 2002 08:38:35 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:7693 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S291042AbSBLNiV>;
	Tue, 12 Feb 2002 08:38:21 -0500
Date: Tue, 12 Feb 2002 14:38:16 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Florian Hars <florian@hars.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unknown Southbridge (was: Disk-I/O and kupdated@99.9% system (2.4.18-pre9))
Message-ID: <20020212143816.A19597@suse.cz>
In-Reply-To: <20020208164250.GA321@bik-gmbh.de> <20020212102005.GB365@bik-gmbh.de> <20020212112349.A1691@suse.cz> <20020212133619.GA324@bik-gmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020212133619.GA324@bik-gmbh.de>; from florian@hars.de on Tue, Feb 12, 2002 at 02:36:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2002 at 02:36:19PM +0100, Florian Hars wrote:
> begin  Vojtech Pavlik quote:
> > On Tue, Feb 12, 2002 at 11:20:05AM +0100, Florian Hars wrote:
> > > I use a Gigabyte GA-7VTXE with a VIA KT266A chipset and a Southbridge
> > > called VT8233A, which does not look like one of the "FUTURE_BRIDGES"
> > 
> > 2.5.2 (and later, and maybe some earlier versions as well) have support
> > for this chipset. You can copy over the via82cxxx.c and ide-timing.h to
> > your kernel and it should work.
> 
> Not really:
> 
> via82cxxx.c: In function `ide_init_via82cxxx':
> via82cxxx.c:548: structure has no member named `highmem'
> make[4]: *** [via82cxxx.o] Fehler 1

Yes, it's for 2.5.

> I had to remove the offending line (it isn't there in the 2.4 version
> of the file), and of course add the PCI ID of the SouthBridge in
> the appropriate places. Now the system boots and hdparm says that
> dma is activated. So lets see how well it behaves...

I've sent a patch to Jens Axboe for inclusion into 2.4, so it might be
in 2.4.18. If you find any flaws, please tell me soon enough so I can
stop the inclusion in time ...

-- 
Vojtech Pavlik
SuSE Labs
