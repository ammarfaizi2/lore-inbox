Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbTDBAeT>; Tue, 1 Apr 2003 19:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261352AbTDBAeT>; Tue, 1 Apr 2003 19:34:19 -0500
Received: from mail.internetwork-ag.de ([217.6.75.131]:46518 "EHLO
	mail.internetwork-ag.de") by vger.kernel.org with ESMTP
	id <S261290AbTDBAeS>; Tue, 1 Apr 2003 19:34:18 -0500
Message-ID: <3E8A3291.F8397F43@inw.de>
Date: Tue, 01 Apr 2003 16:45:05 -0800
From: Till Immanuel Patzschke <tip@inw.de>
Organization: interNetwork AG
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-4GB i686)
X-Accept-Language: en
MIME-Version: 1.0
To: chas williams <chas@locutus.cmf.nrl.navy.mil>
CC: linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Linux-ATM-General] Re: [ATM] second pass at fixing atm spinlock
References: <200304011628.h31GSXGi000846@locutus.cmf.nrl.navy.mil>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chas,

thanks for having taken the job of cleaning this up!!!
I've merged your 2.4 patch w/ my changes and check w/ a couple of thousand PPPoA
sessions created and destroyed over night (which always triggered the
locking/unlocking vcc problems on my SMP box).
I'll let you know how it goes by tomorrow.

One comment on the patch - the change in the net/atm/Makefile (i.e. changing
O_TARGET into atmdev.o) didn't work in my environment (main Makefile still links
atm.o), but I haven't had time to check it out any further - I am using the old
Makefile for now.

Thanks again - and yes, I am using the he155 card :-)

Immanuel
chas williams wrote:

> >ftp://ftp.cmf.nrl.navy.mil/pub/chas/linux-atm/2_5_64_atm_dev_lock.patch
>
> i have made an equivalent version of these patches for 2.4.20 in hopes
> of getting more feedback.
>
> ftp://ftp.cmf.nrl.navy.mil/pub/chas/linux-atm/2_4_20_atm_dev_lock.patch
>
> (only the nicstar, fore200e, eni and he (included) driver support the
> new smp 'safe' locking)
>

