Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269375AbUINNNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269375AbUINNNZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 09:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269357AbUINNNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 09:13:08 -0400
Received: from higgs.elka.pw.edu.pl ([194.29.160.5]:64972 "EHLO
	higgs.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id S269377AbUINNJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 09:09:18 -0400
From: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
To: <syphir@syphir.sytes.net>
Subject: Re: Changes to ide-probe.c in 2.6.9-rc2 causing improper detection
Date: Tue, 14 Sep 2004 13:59:27 +0200
User-Agent: KMail/1.6.2
Cc: "'Jens Axboe'" <axboe@suse.de>, <linux-kernel@vger.kernel.org>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAA6P8AlyGHikORXOqFZ6fdPAEAAAAA@syphir.sytes.net>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAA6P8AlyGHikORXOqFZ6fdPAEAAAAA@syphir.sytes.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409141359.27558.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


always cc: linux-ide@vger.kernel.org on ATA stuff

On Tuesday 14 September 2004 09:03, C.Y.M. wrote:
> 
> > 
> > On Mon, Sep 13 2004, C.Y.M. wrote:
> > > After installing 2.6.9-rc2 on my PC today (x86 VIA Chipset 
> > motherboard and
> > > Athlon XP CPU), The IDE detection during boot in probing 
> > for ide2-5 and
> > > displaying errors, and the hard drives that it does find 
> > are telling me that
> > > "hda: cache flushes not supported" (when they are displayed 
> > as supported
> > > when using 2.6.9-rc1.
> > 
> > Your drive doesn't advertise FLUSH_CACHE support, the model 
> > for when we
> > use these commands changed between -rc1 and -rc2. This 
> > essentially means
> > that you have to turn off write back caching for safe operations on a
> > journalled drive.
> > 
> > Alan, I bet there are a lot of these. Maybe we should consider letting
> > the user manually flag support for FLUSH_CACHE, at least it 
> > is in their
> > hands then.
> > 
> > -- 
> > Jens Axboe
> > 
> 
> Thanks for the explanation.  I can understand that some of the older drives
> will not support FLUSH_CACHE which is acceptable. On another note, since
> most computers only have IDE0 and IDE1 slots, is there a way to prevent the
> probe from returning errors on boot when looking for IDE2 to IDE5?  Perhaps

errros?  these are innocent KERN_DEBUG messages

> a kernel configuration option asking how many IDE's are expected to probe
> (defaulting to two)?

grep drivers/ide/Kconfig IDE_GENERIC

> Best Regards,
> C.Y.M.
