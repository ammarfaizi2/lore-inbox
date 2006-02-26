Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751359AbWBZRlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWBZRlI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 12:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751362AbWBZRlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 12:41:07 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36541 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751359AbWBZRlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 12:41:05 -0500
Subject: Re: Kernel SeekCompleteErrors... Different from Re: LibPATA code
	issues / 2.6.15.4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Mark Lord <liml@rtr.ca>, James Courtier-Dutton <James@superbug.co.uk>,
       David Greaves <david@dgreaves.com>,
       Justin Piszcz <jpiszcz@lucidpixels.com>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, htejun@gmail.com
In-Reply-To: <20060226171307.GA9682@gallifrey>
References: <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca>
	 <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca>
	 <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca>
	 <44019E96.20804@superbug.co.uk> <4401B378.3030005@rtr.ca>
	 <4401BB85.7070407@superbug.co.uk> <4401DF6B.9010409@rtr.ca>
	 <20060226171307.GA9682@gallifrey>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 26 Feb 2006 17:43:11 +0000
Message-Id: <1140975791.27539.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2006-02-26 at 17:13 +0000, Dr. David Alan Gilbert wrote:
> > The *only* test that matters is to enable S.M.A.R.T.,
> > and read out the error logs from it.

SMART is unreliable for many cases

> I have seen a set of drives that has reported UncorrectableErrors
> and :
>     * Shows the Uncorrectable error in the SMART log
>     * Passes a full SMART test
>     * Shows no remapped sectors
>     * Passes the vendors drive test
>     * Now fully passes a dd if=/dev/hdx of=/dev/null with no errors.

The very early SATA code didnt decode the errors from the drive fully so
could produce bogus reports. The current code decodes it and also
displays the ATA level diagnostics so should be reliable.

