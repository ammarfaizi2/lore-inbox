Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272330AbTG3X0j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 19:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272332AbTG3X0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 19:26:38 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:38149
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S272330AbTG3X0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 19:26:35 -0400
Date: Wed, 30 Jul 2003 16:17:21 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
cc: Pavel Machek <pavel@ucw.cz>, alan@redhat.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Warn about taskfile?
In-Reply-To: <Pine.SOL.4.30.0307302336410.1566-100000@mion.elka.pw.edu.pl>
Message-ID: <Pine.LNX.4.10.10307301615190.19607-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bartlomiej,

It is the port not the driver.
Proof is PIO read and writes work, and DMA reads work.
DMA writes is directly related the the SG construction, this was an issue
w/ ia64 w/ atapi and addon cards.  In the end the given vendor determined
it was their problem (./arch/*) and not the driver.

-a

On Wed, 30 Jul 2003, Bartlomiej Zolnierkiewicz wrote:

> 
> On Wed, 30 Jul 2003, Pavel Machek wrote:
> 
> > Hi!
> >
> > I had some strange fs corruption, and andi suggested that it probably
> > is TASKFILE-related. Perhaps this is good idea?
> 
> Idea is good.
> 
> Did corruption go away after disabling taskfile?
> Taskfile was by default on for 2.5.72 and 2.5.73 and Andi's unexplained
> x86-64 + AMD8111 corruption was the only one reported to me / on lkml.
> 
> dmesg and hdparm /dev/scratchdisk for a start, please.
> 
> --
> Bartlomiej
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

