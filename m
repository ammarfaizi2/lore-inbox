Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263709AbUGFIeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbUGFIeI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 04:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUGFIeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 04:34:08 -0400
Received: from cantor.suse.de ([195.135.220.2]:46548 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263709AbUGFIeE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 04:34:04 -0400
Date: Tue, 6 Jul 2004 10:33:11 +0200 (CEST)
From: Steffen Winterfeldt <snwint@suse.de>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Andries Brouwer <aebr@win.tue.nl>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>, bug-parted@gnu.org,
       Thomas Fehr <fehr@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Clausen <clausen@gnu.org>, buytenh@gnu.org, msw@redhat.com
Subject: Re: Restoring HDIO_GETGEO semantics for 2.6 (was: Re: [RFC] Restoring
 HDIO_GETGEO semantics)
In-Reply-To: <Pine.LNX.4.21.0407060020110.29315-100000@mlf.linux.rulez.org>
Message-ID: <Pine.LNX.4.58.0407061017030.13275@ligeti.suse.de>
References: <Pine.LNX.4.21.0407060020110.29315-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jul 2004, Szakacsits Szabolcs wrote:

> On Mon, 5 Jul 2004, Bartlomiej Zolnierkiewicz wrote:
> > On Monday 05 of July 2004 23:08, Andries Brouwer wrote:

[...]

> Are you really not aware of the seriousness of the issue? Didn't you read
> the bugzilla URL's sent? LWN, Eweeks, O'Reilly, OSNews, Slashdot, Amazon
> and many others discussed this 2.6 kernel problem already. Only kernel
> developers aren't aware of it? :-o
> 
> > > Also "the old situation" is badly defined. The returned value differs
> > > for 2.0, 2.2, 2.4, 2.6.
> 
> 2.4 was slightly broken. 2.6 is much more broken than 2.4 from the
> number of partition table corruptions point of view.

Neither 2.6 nor 2.4 are broken. It was well known all the time that
HDIO_GETGEO returns CHS values that are close to useless: all partitioning
tools spend lots of time on partition table guesswork. I really don't see a
point in blaming 2.6 here.

Nevertheless we have the fact that parted and kernel 2.6 don't work well
together. Now what? To get out of this people have to get either a changed
parted or a changed kernel.

And IMO it's far better to fix parted than to reintroduce an obscure piece
of code into the kernel.


Steffen
