Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266377AbRGYB01>; Tue, 24 Jul 2001 21:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268535AbRGYB0H>; Tue, 24 Jul 2001 21:26:07 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:50188 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S266377AbRGYB0B>; Tue, 24 Jul 2001 21:26:01 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: [RFC] Optimization for use-once pages
Date: Wed, 25 Jul 2001 03:30:34 +0200
X-Mailer: KMail [version 1.2]
Cc: Rik van Riel <riel@conectiva.com.br>, <jlnance@intrex.net>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0107241355090.20326-100000@duckman.distro.conectiva> <5.1.0.14.2.20010725013436.00a91880@pop.cus.cam.ac.uk>
In-Reply-To: <5.1.0.14.2.20010725013436.00a91880@pop.cus.cam.ac.uk>
MIME-Version: 1.0
Message-Id: <0107250330340D.00520@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Wednesday 25 July 2001 02:43, Anton Altaparmakov wrote:
> At 01:04 25/07/2001, Daniel Phillips wrote:
> >At that size you'd run a real risk of missing the tell-tale multiple
> >references that mark a page as frequently used.  Think about
> > metadata here (right now, that usually just means directory pages,
> > but later... who knows).
>
> This is not actually implemented yet, but NTFS TNG will use the page
> cache to hold both the LCN (physical clusters) and MFT (on disk
> inodes) allocation bitmaps in addition to file and directory pages.
> (Admittedly the LCN case folds into the file pages in page cache one
> as the LCN bitmap is just stored inside the usual data of a file
> called $Bitmap, but the MFT case is more complex as it is in an
> additional attribute inside the file $MFT so the normal file
> read/write functions definitely cannot be used. The usual data here
> is the actual on disk inodes...)
>
> Just FYI.

Yes, not a surprise.  Plus, I was working on an experimental patch to 
put Ext2 index blocks into the page cache just before I got off on this 
use-once tangent.  Time to go back to that...

--
Daniel
