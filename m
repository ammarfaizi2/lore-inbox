Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285118AbRLFLbe>; Thu, 6 Dec 2001 06:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285119AbRLFLbY>; Thu, 6 Dec 2001 06:31:24 -0500
Received: from mustard.heime.net ([194.234.65.222]:51398 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S285118AbRLFLbV>; Thu, 6 Dec 2001 06:31:21 -0500
Date: Thu, 6 Dec 2001 12:31:03 +0100 (CET)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: Andrew Morton <akpm@zip.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: /proc/sys/vm/(max|min)-readahead effect????
In-Reply-To: <3C0E7FEE.2770EDF4@zip.com.au>
Message-ID: <Pine.LNX.4.30.0112061230480.15030-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!

It works

On Wed, 5 Dec 2001, Andrew Morton wrote:

> Roy Sigurd Karlsbakk wrote:
> >
> > hi all
> >
> > I've just upgraded to 2.4.16 to get /proc/sys/vm/(max|min)-readahead
> > available. I've got this idea...
> >
> > If lots of files (some hundered) are read simultaously, I waste all the
> > i/o time in seeks. However, if I increase the readahead, it'll read more
> > data at a time, and end up with seeking a lot less.
> >
> > The harddrive I'm testing this with, is a cheap 20G IDE drive.
>
> /proc/sys/vm/*-readhead is a no-op for IDE.  It doesn't do
> anything.   You must use
>
> 	echo file_readahead:100 > /proc/ide/ide0/hda/settings
>
> to set the readhead to 100 pages (409600 bytes).
>
> -
>

--
Roy Sigurd Karlsbakk, MCSE, MCNE, CLS, LCA

Computers are like air conditioners.
They stop working when you open Windows.

