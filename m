Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290389AbSA3Sb4>; Wed, 30 Jan 2002 13:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290333AbSA3SaZ>; Wed, 30 Jan 2002 13:30:25 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:6615 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S290379AbSA3S3l>;
	Wed, 30 Jan 2002 13:29:41 -0500
Date: Wed, 30 Jan 2002 13:29:39 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@bonn-fries.net>, mingo@elte.hu,
        Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130132939.B29606@havoc.gtf.org>
In-Reply-To: <20020130171126.GA26583@kroah.com> <E16VzZj-00082y-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16VzZj-00082y-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Jan 30, 2002 at 06:35:15PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 06:35:15PM +0000, Alan Cox wrote:
> > Especially after spelunking through the SCSI drivers, and being amazed
> > that only one of them uses the, now two year old, pci_register_driver()
> > interface (which means that only that driver works properly in PCI
> > hotplug systems.)
> 
> I doubt it does actually. The problem with pci register driver and scsi is
> that the two subsystems are designed with violently conflicting goals. Once
> DaveJ or someone does the proposed scsi cleanups it'll become the natural
> not the obscenely complicated way to do a scsi driver, as well as sorting out
> the pcmcia and cardbus scsi mess, and the card failed/recovered stuff once and
> for all.

I disagree... I outlined a workable scheme for hotplugging SCSI
controllers to Justin Gibbs a long time ago, when the new aic7xxx was
first being merged.  Using the new PCI API was fairly easy, handling the
disk-disappearing-from-under-you problem was a bit more annoying :)

	Jeff



