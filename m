Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263113AbTJPS4X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 14:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263115AbTJPS4X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 14:56:23 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7040 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263113AbTJPS4O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 14:56:14 -0400
Date: Thu, 16 Oct 2003 14:56:04 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: John Bradford <john@grabjohn.com>
cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org, val@nmt.edu
Subject: Re: Transparent compression in the FS
In-Reply-To: <200310161828.h9GISxlN001783@81-2-122-30.bradfords.org.uk>
Message-ID: <Pine.LNX.4.53.0310161453240.814@chaos>
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl>
 <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random>
 <20031016172930.GA5653@work.bitmover.com> <200310161828.h9GISxlN001783@81-2-122-30.bradfords.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Oct 2003, John Bradford wrote:

> Quote from Larry McVoy <lm@bitmover.com>:
> > On Wed, Oct 15, 2003 at 11:13:27AM -0400, Jeff Garzik wrote:
> > > Josh and others should take a look at Plan9's venti file storage method
> > > -- archival storage is a series of unordered blocks, all of which are
> > > indexed by the sha1 hash of their contents.  This magically coalesces
> > > all duplicate blocks by its very nature, including the loooooong runs of
> > > zeroes that you'll find in many filesystems.  I bet savings on "all
> > > bytes in this block are zero" are worth a bunch right there.
> >
> > The only problem with this is that you can get false positives.  Val Hensen
> > recently wrote a paper about this.  It's really unlikely that you get false
> > positives but it can happen and it has happened in the field.
>
> Surely it's just common sense to say that you have to verify the whole
> block - any algorithm that can compress N values into <N values is
> lossy by definition.  A mathematical proof for that is easy.
>
> John.

No! Not true. 'lossy' means that you can't recover the original
data. Some music compression and video compression schemes are
lossy. If you can get back the exact input data, it's not lossy.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


