Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265154AbTAAWsJ>; Wed, 1 Jan 2003 17:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265168AbTAAWsJ>; Wed, 1 Jan 2003 17:48:09 -0500
Received: from mx7.mail.ru ([194.67.57.17]:38672 "EHLO mx7.mail.ru")
	by vger.kernel.org with ESMTP id <S265154AbTAAWsI>;
	Wed, 1 Jan 2003 17:48:08 -0500
Date: Wed, 1 Jan 2003 23:55:30 +0100 (CET)
From: Guennadi Liakhovetski <lyakh@mail.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Bill Davidsen <davidsen@tmr.com>, Guennadi Liakhovetski <lyakh@mail.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-scsi CD-recorder error reading burned disks
In-Reply-To: <1041453464.21708.5.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0301012323220.3378-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is caused by either the way you burn it, or the inability of cdrecord
> > to create a CD which doesn't do this. It's related to read-ahead, but I
> > don't remember the exact detail. In any case, you *may* be able to get rid
> > of the problem by using -pad in mkisofs, or in cdrecord.

I used -isosize (copying from another CD), which has an effect similar to
-pad. Just tried with -pad - same. -dao, as suggested by Kasper Dupont
<kasperd@daimi.au.dk>, doesn't help either. On the contrary, the latter
makes the error appear in all 3 reads - ide-scsi, ide, scsi (I used it
together with -isosize). Also strange, the number of blocks read by dd
bs=2048 on ide and scsi from the same disk differ...

> Sounds like a scsi error handling funny more than anything else. The end
> of disk case for cd-r/cd-rw burned disks are a bit fuzzier than normal
> disks. The ide-cd layer knows about this.

But, as I described, a native SCSI-CD/DVD-drive reads this disk without
problems.

Thanks
---
Guennadi Liakhovetski



