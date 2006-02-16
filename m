Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbWBPUEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbWBPUEW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 15:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964896AbWBPUEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 15:04:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:23839 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964894AbWBPUEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 15:04:20 -0500
Date: Thu, 16 Feb 2006 21:01:39 +0100
From: Jens Axboe <axboe@suse.de>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, "Brown, Len" <len.brown@intel.com>,
       "David S. Miller" <davem@davemloft.net>, linux-acpi@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net,
       "Yu, Luming" <luming.yu@intel.com>, Ben Castricum <lk@bencastricum.nl>,
       sanjoy@mrao.cam.ac.uk, Helge Hafting <helgehaf@aitel.hist.no>,
       "Carlo E. Prelz" <fluido@fluido.as>,
       Gerrit Bruchh?user <gbruchhaeuser@gmx.de>, Nicolas.Mailhot@LaPoste.net,
       Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>,
       Patrizio Bassi <patrizio.bassi@gmail.com>,
       Bj?rn Nilsson <bni.swe@gmail.com>, Andrey Borzenkov <arvidjaar@mail.ru>,
       "P. Christeas" <p_christ@hol.gr>, ghrt <ghrt@dial.kappa.ro>,
       jinhong hu <jinhong.hu@gmail.com>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>, linux-scsi@vger.kernel.org,
       Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: Linux 2.6.16-rc3
Message-ID: <20060216200138.GA4203@suse.de>
References: <20060212190520.244fcaec.akpm@osdl.org> <20060213203800.GC22441@kroah.com> <1139934883.14115.4.camel@mulgrave.il.steeleye.com> <1140054960.3037.5.camel@mulgrave.il.steeleye.com> <20060216171200.GD29443@flint.arm.linux.org.uk> <1140112653.3178.9.camel@mulgrave.il.steeleye.com> <20060216180939.GF29443@flint.arm.linux.org.uk> <1140113671.3178.16.camel@mulgrave.il.steeleye.com> <20060216181803.GG29443@flint.arm.linux.org.uk> <1140116969.3178.24.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1140116969.3178.24.camel@mulgrave.il.steeleye.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16 2006, James Bottomley wrote:
> On Thu, 2006-02-16 at 18:18 +0000, Russell King wrote:
> > Maybe implementing it as a helper function would be the best and
> > simplest solution?
> > 
> > static void scsi_release(struct device *dev)
> > {
> > 	schedule_release_process(dev, scsi_release_process);
> > }
> > 
> > where schedule_release_process() contains more or less what I posted
> > in the previous mailing.
> 
> That's almost exactly the execute_in_process_context() API that began
> this discussion (and which Andi NAK'd).  However, it could possibly be
> resurrected with the proviso that the caller has to feed in the
> workqueue memory.  How would people feel about that?

That's what I suggested in the first place as well. I still think it's a
good idea, fwiw :)

-- 
Jens Axboe

