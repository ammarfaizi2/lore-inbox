Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274920AbTGaWVE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 18:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274917AbTGaWS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 18:18:58 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:9725 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S274912AbTGaWSr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 18:18:47 -0400
Date: Fri, 1 Aug 2003 00:17:31 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Andrew Morton <akpm@osdl.org>
cc: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Disk performance degradation
In-Reply-To: <20030731141517.0ceccc77.akpm@osdl.org>
Message-ID: <Pine.SOL.4.30.0307312351500.6434-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 31 Jul 2003, Andrew Morton wrote:

> mru@users.sourceforge.net (Måns Rullgård) wrote:
> >
> > Mike Dresser <mdresser_l@windsormachine.com> writes:
> >
> > > Probably for reasons like that.  For some reason, I can't set my ICH4
> > > based controller(ASUS P4B533) and Quantum Fireball AS40.0 to more than
> > > 255.  Kernel is 2.4.21
> >
> > It appears that in 2.[56] kernels the unit for readahead is bytes,
> > rather than sectors, as used in 2.4 kernels.
>
> The ioctl which is used by
>
> 	blockdev --setra
>
> is still in 512-byte units.
>
> There are other backdoors such as IDE-private /proc files which can be used
> to set readahead.  I'm not sure what units they use, and I don't know what
> mechanism hdparm is using to diddle readahead.

in 2.4.x:

/proc/ide/hdX/settings

breada_readahead - BLKRA{GET/SET}
file_readahead - BLKFRA{GET/SET}

both are in 1024 bytes units

in 2.6.x they are gone :-).

and hdparm is using BLKRA{GET/SET}

--
Bartlomiej

