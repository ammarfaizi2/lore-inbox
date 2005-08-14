Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932557AbVHNP4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbVHNP4l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Aug 2005 11:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932558AbVHNP4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Aug 2005 11:56:41 -0400
Received: from nproxy.gmail.com ([64.233.182.203]:46960 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932557AbVHNP4k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Aug 2005 11:56:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rApUNLjiwc8mUvUynYLdxbrfr8Fa5YuYUrIVwOL70Ea56h622ngw4PPeV+cBP08P5dw0CpvTtIEEOA87nm892zQhmR2ZuvYGR2pic7GuTbDGFVH1ft6u6oyZJ2Ret2jJEJa2aAoFPBqf8bi3wlZhJhedEW9gESsaV1hR59yWPzw=
Message-ID: <58cb370e050814085613ccc42c@mail.gmail.com>
Date: Sun, 14 Aug 2005 17:56:37 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: IT8212/ITE RAID
Cc: Daniel Drake <dsd@gentoo.org>, CaT <cat@zip.com.au>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1124034767.14138.55.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050814053017.GA27824@zip.com.au> <42FF263A.8080009@gentoo.org>
	 <20050814114733.GB27824@zip.com.au> <42FF3CBA.1030900@gentoo.org>
	 <1124026385.14138.37.camel@localhost.localdomain>
	 <58cb370e050814080120291979@mail.gmail.com>
	 <1124034767.14138.55.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> On Sul, 2005-08-14 at 17:01 +0200, Bartlomiej Zolnierkiewicz wrote:
> > > Thats probably the fact other patches from -ac are missing in base. It
> > > should be harmless.
> >
> > Therefore please submit them.
> 
> Cut the crap, you know I've submitted the stuff again and again and
> again along with other fixes, reports of stuff you broke you ignored
> etc. So I got bored of playing your games.

* your stuff was accepted after all (and some stuff like ide-cd
  fixes was never splitted from the -ac patchset and submitted)

* you've never provided any technical details on "the stuff I broke"

Can't you get over this bullshit please?  Life goes on.

> > > > > [227523.229631] hda: cache flushes not supported
> > > > > [227523.229932]  hda:hda: recal_intr: status=0x51 { DriveReady SeekComplete Error }
> > > > > [227523.230905] hda: recal_intr: error=0x04 { DriveStatusError }
> > > > > [227523.230952] ide: failed opcode was: unknown
> > >
> > > Yep - on my "wtf" list. In some cases we send a strange command to the
> > > IT8212 drive. I'm still trying to find the guilty command we send (none
> > > of my drives do this), so that I can fix the ident adjustment to stop
> > > it. The noise is just the command being rejected which is ok but messy
> > > and wants stomping.
> >
> > small hint: WIN_RESTORE
> 
> Would make sense, but I thought I had the right bits masked. Will take a

WIN_RESTORE is send unconditionally (as it always was),

This is not the right thing, somebody should go over all ATA/ATAPI
drafts and come with the correct strategy of handling WIN_RESTORE.

> look tomorrow however.
