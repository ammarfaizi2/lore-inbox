Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269172AbUINHDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269172AbUINHDh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 03:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269176AbUINHDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 03:03:37 -0400
Received: from dialup-4.246.93.207.Dial1.SanJose1.Level3.net ([4.246.93.207]:45696
	"EHLO nofear.bounceme.net") by vger.kernel.org with ESMTP
	id S269172AbUINHDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 03:03:35 -0400
Reply-To: <syphir@syphir.sytes.net>
From: "C.Y.M." <syphir@syphir.sytes.net>
To: "'Jens Axboe'" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>, "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: RE: Changes to ide-probe.c in 2.6.9-rc2 causing improper detection
Date: Tue, 14 Sep 2004 00:03:09 -0700
Organization: CooLNeT
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAA6P8AlyGHikORXOqFZ6fdPAEAAAAA@syphir.sytes.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcSaITGan1Q6QUCHRs6UAnWOXNOeEQABnuxA
In-Reply-To: <20040914060628.GC2336@suse.de>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> On Mon, Sep 13 2004, C.Y.M. wrote:
> > After installing 2.6.9-rc2 on my PC today (x86 VIA Chipset 
> motherboard and
> > Athlon XP CPU), The IDE detection during boot in probing 
> for ide2-5 and
> > displaying errors, and the hard drives that it does find 
> are telling me that
> > "hda: cache flushes not supported" (when they are displayed 
> as supported
> > when using 2.6.9-rc1.
> 
> Your drive doesn't advertise FLUSH_CACHE support, the model 
> for when we
> use these commands changed between -rc1 and -rc2. This 
> essentially means
> that you have to turn off write back caching for safe operations on a
> journalled drive.
> 
> Alan, I bet there are a lot of these. Maybe we should consider letting
> the user manually flag support for FLUSH_CACHE, at least it 
> is in their
> hands then.
> 
> -- 
> Jens Axboe
> 

Thanks for the explanation.  I can understand that some of the older drives
will not support FLUSH_CACHE which is acceptable. On another note, since
most computers only have IDE0 and IDE1 slots, is there a way to prevent the
probe from returning errors on boot when looking for IDE2 to IDE5?  Perhaps
a kernel configuration option asking how many IDE's are expected to probe
(defaulting to two)?

Best Regards,
C.Y.M.

