Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277294AbRKNU04>; Wed, 14 Nov 2001 15:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277341AbRKNU0q>; Wed, 14 Nov 2001 15:26:46 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:16638
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S277294AbRKNU01>; Wed, 14 Nov 2001 15:26:27 -0500
Date: Wed, 14 Nov 2001 12:26:20 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Erik Tews <erik.tews@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux readahead setting?
Message-ID: <20011114122620.A10172@mikef-linux.matchmail.com>
Mail-Followup-To: Erik Tews <erik.tews@gmx.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0111131619230.1290-100000@mustard.heime.net> <Pine.LNX.4.33L.0111131355030.20809-100000@duckman.distro.conectiva> <20011113181650.A30354@no-maam.dyndns.org> <20011113220139.B30354@no-maam.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011113220139.B30354@no-maam.dyndns.org>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2001 at 10:01:39PM +0100, Erik Tews wrote:
> Thanks, for all the answers via pm, but I would like to explain a litte
> bit more what I am looking for. I got this filesystem on lvm, and I want
> my harddisk if there a several processes accessing the disk-image to go
> to the position of process one, read 256k of data, go to the position of
> process two, read 256k of data, go again to the position of the nex
> process, read 256k of data and so one to minimize movement of the
> harddisk-readhead.
>

At which level do you want the read ahead?

If you read ahead at the block level, you may not get data for the file you
want because of fragmentation.  This is especially true with long running
Reiser file systems.

If you read ahead at the FS level, you could get even more seeking because
of fragmentation.

Also, you need enough memory to let the kernel hold the read ahead data long
enough to be used.

Mike
