Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314546AbSGDWEZ>; Thu, 4 Jul 2002 18:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314514AbSGDWEX>; Thu, 4 Jul 2002 18:04:23 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:3928 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S314546AbSGDWDr>; Thu, 4 Jul 2002 18:03:47 -0400
Date: Thu, 4 Jul 2002 21:51:46 +0100
From: Stephen Tweedie <sct@redhat.com>
To: Anton Altaparmakov <aia21@cantab.net>, sct@redhat.com,
       Andrew Morton <akpm@zip.com.au>, LKML <linux-kernel@vger.kernel.org>,
       ext3-users@redhat.com
Subject: Re: EXT3-fs error on kernel 2.4.18-pre3
Message-ID: <20020704215146.E27198@redhat.com>
References: <1025723138.3817.10.camel@storm.christs.cam.ac.uk> <20020703202107.GA14654@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020703202107.GA14654@clusterfs.com>; from adilger@turbolinux.com on Wed, Jul 03, 2002 at 02:21:07PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 03, 2002 at 02:21:07PM -0600, Andreas Dilger
<adilger@turbolinux.com> wrote:

> On Jul 03, 2002  20:05 +0100, Anton Altaparmakov wrote:
> > I just noticed that my file server running 2.4.18-pre3 + IDE patches &
> > NTFS patches has this error message in the logs:
> > 
> > EXT3-fs error (device md(9,4)): ext3_free_blocks: Freeing blocks not in
> > datazone - block = 33554432, count = 1
> > 
> > This is the only ext3 error I have seen and the uptime is currently over
> > 74 days. The error actually appeared two weeks ago. The timing coincides
> > well with when this device (/dev/md4, a MD RAID-1 array) ran out of
> > space, so it may well be related.
> 
> This was fixed in newer kernels.

No, the out-of-space behaviour was either an ext3_error if we ran out
of inodes, or a minor i_nrblocks accounting error if we ran out of
disk blocks.

The bad pointer here is 0x2000000, and a bit flip like that is more
often an indicator of bad memory than anything else.

Cheers,
 Stephen
