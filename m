Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262267AbTERXYC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 19:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbTERXYB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 19:24:01 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:33666 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262267AbTERXYA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 19:24:00 -0400
Date: Mon, 19 May 2003 01:36:45 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andre Hedrick <andre@linux-ide.org>
cc: Adrian Bunk <bunk@fs.tum.de>, <alan@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Erik Andersen <andersen@codepoet.org>, <trivial@rustcorp.com.au>
Subject: Re: [2.5 patch] 2.4.21-rc1 pointless IDE noise reduction
In-Reply-To: <Pine.LNX.4.10.10305181510170.32050-100000@master.linux-ide.org>
Message-ID: <Pine.SOL.4.30.0305190124510.12436-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 18 May 2003, Andre Hedrick wrote:

> Just maybe people would like to know if there is a secret OS on the tail
> of their drive, or the potential for one being there.

This function only checks for HPA command set enabled (not supported).

I find it only useful when we see failed command in logs
and ">= 0", then we now it was READ_NATIVE_MAX command.

We check for secret OS in init_idedisk_capacity(). :-)

> Go research EDDS BEER PARTIES and you will find out this is not a joke.
>
> If the noise pisses you off turn down your kernel printk noise makers.
> Better yet stub it out in your own kernel.
>
> Do not remove items that have meaning or valid tests.

It is covered by init_idedisk_capacity() (capacity != native capacity)
and hdparm (HPA command set supported/enabled).

Can it go away?

Cheers,
--
Bartlomiej

> Erik, get over it and just live with a stub out.
>
> Cheers,
>
> On Sun, 18 May 2003, Adrian Bunk wrote:
>
> > Below is a 2.5 version of the patch to remove
> > idedisk_supports_host_protected_area.
> >
> > I've tested the compilation with 2.5.69-mm6.

