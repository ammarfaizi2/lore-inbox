Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264528AbTK2W3j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 17:29:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbTK2W3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 17:29:39 -0500
Received: from mail018.syd.optusnet.com.au ([211.29.132.72]:34016 "EHLO
	mail018.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264528AbTK2W3h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 17:29:37 -0500
Date: Sun, 30 Nov 2003 09:33:50 +1100
From: Andrew Clausen <clausen@gnu.org>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Andries Brouwer <aebr@win.tue.nl>, Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Message-ID: <20031129223349.GC505@gnu.org>
References: <20031128045854.GA1353@home.woodlands> <20031128142452.GA4737@win.tue.nl> <20031129022221.GA516@gnu.org> <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi>
X-Accept-Language: en,pt
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 29, 2003 at 07:16:31AM +0200, Szakacsits Szabolcs wrote:
> > Yes there is.  "Correct" is defined by the BIOS.  It is important
> > for boot loaders (in particular Windows).  
> 
> I suspected the same ... What Windows you mean? DOS (9x/ME/etc) or NT based
> (NT4/2000/XP/2003)? All?

Good question.  From 98 up, Windows supports both LBA and CHS.  I'm not
sure about XP/2003.  The real question is: what is the default install?
How many users have each?

> Also, can Parted save/restore the full and exact partition table a
> scriptable way? I mean something like this:
> 
> 	sfdisk -d /dev/hda > hda.pt       # save
> 	sfdisk /dev/hda < hda.pt          # restore
> 
> sfdisk can't recover geometry so apparently no one-liner, widely available,
> partition table backup/recovery is possible at present on Linux :-o
> dd if=/dev/hda of=hda.mbr bs=512 count=1 won't save the logical partitions.

Parted can't do it.  :/

Cheers,
Andrew

