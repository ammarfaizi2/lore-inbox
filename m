Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266337AbUBDUc1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 15:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264441AbUBDU3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 15:29:43 -0500
Received: from onyx.boisestate.edu ([132.178.208.159]:22430 "EHLO
	onyx.boisestate.edu") by vger.kernel.org with ESMTP id S266337AbUBDU2y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 15:28:54 -0500
Date: Wed, 4 Feb 2004 13:28:41 -0700 (MST)
From: Torin Ford <tford@onyx.boisestate.edu>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: linux-kernel@vger.kernel.org
Subject: Re: Missing IDE Devices in 2.6.2
In-Reply-To: <200402042125.51072.bzolnier@elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.44.0402041328160.9137-100000@onyx.boisestate.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Feb 2004, Bartlomiej Zolnierkiewicz wrote:

> On Wednesday 04 of February 2004 21:01, Torin Ford wrote:
> > I hate to ask such a stupid question, but has something "major" changed in
> > the IDE code between 2.6.1 and 2.6.2 that would cause it not to probe for
> > devices?  I've got 2.6.1 running great.  This morning when I used my 2.6.1
> > config file for 2.6.2 (doing a make oldconfig), everything compiles great.
> > Unfortunately when I boot 2.6.2, it doesn't find any IDE devices.  With
> > 2.6.1, the IDE code would probe and find my ZIP disk, and 2 CDROMs, now
> > with 2.6.2 I get nothing.  Loading ide-cd and/or id-floppy don't do
> > anything either.  Enclosed is my config file.  I've also tried adding and
> > removing different boot params such as:
> 
> Major change is that you can compile generic host driver as module now.
> 
> >From your .config:
> 
> CONFIG_IDE_GENERIC=m
> CONFIG_BLK_DEV_PIIX=m
> 
> Is this intentional?
> Maybe you forgot to load 'piix' module?

That was it.  Thanks much.

Torin

> 
> --bart
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

