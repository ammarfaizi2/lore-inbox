Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266069AbUGENKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266069AbUGENKo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 09:10:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266073AbUGENKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 09:10:43 -0400
Received: from cantor.suse.de ([195.135.220.2]:13701 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266069AbUGENKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 09:10:18 -0400
Date: Mon, 5 Jul 2004 15:10:16 +0200 (CEST)
From: Steffen Winterfeldt <snwint@suse.de>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>, bug-parted@gnu.org,
       Thomas Fehr <fehr@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Clausen <clausen@gnu.org>, buytenh@gnu.org, msw@redhat.com
Subject: Re: Restoring HDIO_GETGEO semantics for 2.6 (was: Re: [RFC] Restoring
 HDIO_GETGEO semantics)
In-Reply-To: <Pine.LNX.4.21.0407041920480.11076-100000@mlf.linux.rulez.org>
Message-ID: <Pine.LNX.4.58.0407051447010.11617@ligeti.suse.de>
References: <Pine.LNX.4.21.0407041920480.11076-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jul 2004, Szakacsits Szabolcs wrote:

> On Sat, 3 Jul 2004, Andries Brouwer wrote:
> > 
> > But it is true, returning 0 in all other fields would have made
> > it more clear that there is no attempt to return the BIOS geometry.
> > It might be a good idea to do that.
> 
> I fail to see how that would solve _now_ the _current_ serious problem
> with HDIO_GETGEO.

It wouldn't, the damage has been done. I just wish HDIO_GETGEO had been
removed rather than changed.

>  1) 2.6 kernels made very visible that the widely used Parted, libparted,
>     etc are severely broken. They should be FIXED. Off-topic on linux-kernel.

It's not *severly* broken. All partitioning tools use some kind of
heuristics and it's just a minor variation compared to, say, fdisk that
makes parted fail.

> Considering all the above points, it seems logical from practical point 
> of view, that the restoration of the old HDIO_GETGEO functionality (or
> something that's very close to its behaviour) _temporarily_ for 2.6
> kernels makes sense.

It's too late. Rather than updating the kernel you could as well update your
favorite partitioning tool.

Changing the semantics of HDIO_GETGEO either way in the (supposedly) stable
2.6.x series it IMHO not a good idea.


Steffen
