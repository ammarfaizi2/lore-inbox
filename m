Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277532AbRKNUsU>; Wed, 14 Nov 2001 15:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277514AbRKNUsK>; Wed, 14 Nov 2001 15:48:10 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:17904
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S277533AbRKNUr7>; Wed, 14 Nov 2001 15:47:59 -0500
Date: Wed, 14 Nov 2001 12:47:53 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Erik Tews <erik.tews@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux readahead setting?
Message-ID: <20011114124753.B10172@mikef-linux.matchmail.com>
Mail-Followup-To: Erik Tews <erik.tews@gmx.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0111131619230.1290-100000@mustard.heime.net> <Pine.LNX.4.33L.0111131355030.20809-100000@duckman.distro.conectiva> <20011113181650.A30354@no-maam.dyndns.org> <20011113220139.B30354@no-maam.dyndns.org> <20011114122620.A10172@mikef-linux.matchmail.com> <20011114214121.A2136@no-maam.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011114214121.A2136@no-maam.dyndns.org>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 14, 2001 at 09:41:22PM +0100, Erik Tews wrote:
> On Wed, Nov 14, 2001 at 12:26:20PM -0800, Mike Fedyk wrote:
> > At which level do you want the read ahead?
> > 
> > If you read ahead at the block level, you may not get data for the file you
> > want because of fragmentation.  This is especially true with long running
> > Reiser file systems.
> 
> I think fragmentation will be no problem, because this filesystem
> contains only one file.
> 
> Readahead should be done on filesystem or block-level. Not on disklevel.
> I can tune that with lvm, but I was not sure if a bigger readahead-value
> is that what I want.

Block and disk are conceptually the same in this instance because neither of
them know if the read ahead is going to get the next blocks for the file
being read or not...

In most cases, block=disk, except for lvm and raid...

Mike
