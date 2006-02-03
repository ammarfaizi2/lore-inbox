Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030226AbWBCTNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030226AbWBCTNI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWBCTNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:13:08 -0500
Received: from kepler.fjfi.cvut.cz ([147.32.6.11]:16015 "EHLO
	kepler.fjfi.cvut.cz") by vger.kernel.org with ESMTP
	id S1030226AbWBCTNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:13:06 -0500
Date: Fri, 3 Feb 2006 20:12:57 +0100 (CET)
From: Martin Drab <drab@kepler.fjfi.cvut.cz>
To: Roger Heflin <rheflin@atipa.com>
cc: "'Phillip Susi'" <psusi@cfl.rr.com>, "'Bill Davidsen'" <davidsen@tmr.com>,
       "'Cynbe ru Taren'" <cynbe@muq.org>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'Salyzyn, Mark'" <mark_salyzyn@adaptec.com>
Subject: RE: FYI: RAID5 unusably unstable through 2.6.14
In-Reply-To: <EXCHG2003KfYDovvQ0P000011f7@EXCHG2003.microtech-ks.com>
Message-ID: <Pine.LNX.4.60.0602032010430.24081@kepler.fjfi.cvut.cz>
References: <EXCHG2003KfYDovvQ0P000011f7@EXCHG2003.microtech-ks.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2006, Roger Heflin wrote:

> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org 
> > [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Martin Drab
> > Sent: Friday, February 03, 2006 11:51 AM
> > To: Phillip Susi
> > Cc: Bill Davidsen; Cynbe ru Taren; Linux Kernel Mailing List; 
> > Salyzyn, Mark
> > Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
> > 
> > On Fri, 3 Feb 2006, Martin Drab wrote:
> > 
> > > On Fri, 3 Feb 2006, Phillip Susi wrote:
> > > 
> > > > Usually drives will fail reads to bad sectors but when 
> > you write to 
> > > > that sector, it will write and read that sector to see if 
> > it is fine 
> > > > after being written again, or if the media is bad in 
> > which case it 
> > > > will remap the sector to a spare.
> > > 
> > > No, I don't think this was the case of a physically bad sectors. I 
> > > think it was just an inconsistency of the RAID controllers metadata 
> > > (or something simillar) related to that particular array.
> > 
> > Or is such a situation not possible at all? Are bad sectors 
> > the only reason that might have caused this? That sounds a 
> > little strange to me, that would have been a very unlikely 
> > concentration of conincidences, IMO. 
> > That's why I still think there are no bad sectors at all (at 
> > least not because of this). Is there any way to actually find out?
> 
> 
> Some of the drive manufacturers have tools that will read out
> "log" files from the disks, and these log files include stuff
> such as how many bad block errors where returned to the host
> over the life of the disk.

S.M.A.R.T. should be able to do this. But last time I've checked it wasn't 
working with Linux and SCSI/SATA. Is this working now?

> You would need a decent contatct with the disk manufacturer, and
> you might be able to get them to tell you, maybe.

Well it's a WD 1600SD.

Martin
