Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbTJMKc6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 06:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbTJMKc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 06:32:58 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:19840 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261661AbTJMKc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 06:32:29 -0400
Date: Mon, 13 Oct 2003 11:33:46 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200310131033.h9DAXkHu000365@81-2-122-30.bradfords.org.uk>
To: "Norman Diamond" <ndiamond@wta.att.ne.jp>, <linux-kernel@vger.kernel.org>
In-Reply-To: <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60>
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60>
 <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk>
 <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60>
Subject: Re: Why are bad disk sectors numbered strangely, and what happens to them?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from "Norman Diamond" <ndiamond@wta.att.ne.jp>:
> John Bradford replied to me:
> 
> > > How can I tell Linux to read every sector in the partition?  Oh, I might
> > > know this one,
> > >   dd if=/dev/hda8 of=/dev/null
> > > I want to make sure that the drive is now using a non-defective
> > > replacement sector.
> >
> > A read won't necessarily do that.  You might have to write to a
> > defective sector to force re-allocation.
> 
> I agree, we are not sure if a read will do that.  That is the reason why two
> of my preceding questions were:
> 
>    How can I find out which file contains the bad sector?  I would like to
>    try to recreate the file from a source of good data.

How are you going to make sure you write it in the same location as it was before?

>    How can I tell Linux to mark the sector as bad, knowing the LBA sector
>    number?

Don't.  If the drive can't fix this problem itself, throw it in the bin.

> And that is also the reason why my last question, which Mr. Bradford replied
> to, had the stated purpose of making sure that the drive is now using a
> non-defective replacement sector after the preceding operations have been
> carried out.

Backup your data.
Run the S.M.A.R.T. tests.
Write over the whole disk with something like dd if=/dev/zero of=/dev/hda.
If you still get errors, replace the disk.

> Please, the important questions are important.  Doesn't anyone really know
> what Linux does with bad blocks, how to find out which file contains them,
> how to get Linux to force them to be marked and reallocated?

John.
