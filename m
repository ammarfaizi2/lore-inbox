Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277509AbRKNUmT>; Wed, 14 Nov 2001 15:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277514AbRKNUmJ>; Wed, 14 Nov 2001 15:42:09 -0500
Received: from pD903C936.dip.t-dialin.net ([217.3.201.54]:29830 "EHLO
	no-maam.dyndns.org") by vger.kernel.org with ESMTP
	id <S277509AbRKNUmA>; Wed, 14 Nov 2001 15:42:00 -0500
Date: Wed, 14 Nov 2001 21:41:22 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: linux readahead setting?
Message-ID: <20011114214121.A2136@no-maam.dyndns.org>
In-Reply-To: <Pine.LNX.4.30.0111131619230.1290-100000@mustard.heime.net> <Pine.LNX.4.33L.0111131355030.20809-100000@duckman.distro.conectiva> <20011113181650.A30354@no-maam.dyndns.org> <20011113220139.B30354@no-maam.dyndns.org> <20011114122620.A10172@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011114122620.A10172@mikef-linux.matchmail.com>
User-Agent: Mutt/1.3.23i
From: erik.tews@gmx.net (Erik Tews)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2001 at 12:26:20PM -0800, Mike Fedyk wrote:
> On Tue, Nov 13, 2001 at 10:01:39PM +0100, Erik Tews wrote:
> > Thanks, for all the answers via pm, but I would like to explain a litte
> > bit more what I am looking for. I got this filesystem on lvm, and I want
> > my harddisk if there a several processes accessing the disk-image to go
> > to the position of process one, read 256k of data, go to the position of
> > process two, read 256k of data, go again to the position of the nex
> > process, read 256k of data and so one to minimize movement of the
> > harddisk-readhead.
> 
> At which level do you want the read ahead?
> 
> If you read ahead at the block level, you may not get data for the file you
> want because of fragmentation.  This is especially true with long running
> Reiser file systems.

I think fragmentation will be no problem, because this filesystem
contains only one file.

Readahead should be done on filesystem or block-level. Not on disklevel.
I can tune that with lvm, but I was not sure if a bigger readahead-value
is that what I want.
