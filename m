Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284671AbRLEUQj>; Wed, 5 Dec 2001 15:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284677AbRLEUP3>; Wed, 5 Dec 2001 15:15:29 -0500
Received: from leeloo.zip.com.au ([203.12.97.48]:35847 "EHLO
	mangalore.zipworld.com.au") by vger.kernel.org with ESMTP
	id <S284674AbRLEUOA>; Wed, 5 Dec 2001 15:14:00 -0500
Message-ID: <3C0E7FEE.2770EDF4@zip.com.au>
Date: Wed, 05 Dec 2001 12:13:34 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: /proc/sys/vm/(max|min)-readahead effect????
In-Reply-To: <Pine.LNX.4.30.0112051713200.2297-100000@mustard.heime.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:
> 
> hi all
> 
> I've just upgraded to 2.4.16 to get /proc/sys/vm/(max|min)-readahead
> available. I've got this idea...
> 
> If lots of files (some hundered) are read simultaously, I waste all the
> i/o time in seeks. However, if I increase the readahead, it'll read more
> data at a time, and end up with seeking a lot less.
> 
> The harddrive I'm testing this with, is a cheap 20G IDE drive.

/proc/sys/vm/*-readhead is a no-op for IDE.  It doesn't do
anything.   You must use

	echo file_readahead:100 > /proc/ide/ide0/hda/settings

to set the readhead to 100 pages (409600 bytes).

-
