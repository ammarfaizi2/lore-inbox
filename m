Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbUL0PtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbUL0PtM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 10:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbUL0PtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 10:49:12 -0500
Received: from hermes.domdv.de ([193.102.202.1]:63242 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261915AbUL0PtC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 10:49:02 -0500
Message-ID: <41D02EEC.4090000@domdv.de>
Date: Mon, 27 Dec 2004 16:49:00 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: Ross Biro <ross.biro@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.10-ac1
References: <1104103881.16545.2.camel@localhost.localdomain>	 <58cb370e04122616577e1bd33@mail.gmail.com> <41CF649E.20409@domdv.de>	 <58cb370e041226174019e75e23@mail.gmail.com>	 <8783be660412270645717b89d1@mail.gmail.com> <58cb370e0412270738fbc045c@mail.gmail.com>
In-Reply-To: <58cb370e0412270738fbc045c@mail.gmail.com>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> Workaround it if it is possible.  If this is really a unfixable hardware problem
> (hard to believe - other OS-es would be also bitten by the issue) shouldn't it
> be workaround differently anyway by something like "ide=serialize_all" (which
> is much saner from IDE POV than "idex=serialize") ?

Bad. This would neatly kill my raid 5 setup performance wise. Call this 
idea a big step sideways. Doing a ide2=serialize leaves all three disks 
running without serialization unless the dvd-rw is used. Just to make it 
clear:
ide0 -> onboard, 1 master (disk)
ide1 -> onboard, 1 master (disk)
ide2/3 -> pci, 2 master (disk,dvd-rw)
Your idea would serialize all ide accesses which would slow down all 
disks not affected by the problem requiring serialization.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
