Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316592AbSFZOSb>; Wed, 26 Jun 2002 10:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316593AbSFZOSa>; Wed, 26 Jun 2002 10:18:30 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:28882 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S316592AbSFZOS3>; Wed, 26 Jun 2002 10:18:29 -0400
Date: Wed, 26 Jun 2002 01:13:40 +0100
From: Stephen Tweedie <sct@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Miles Lane <miles@megapathdsl.net>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Automatically mount or remount EXT3 partitions with EXT2 when alaptop is powered by a battery?
Message-ID: <20020626011340.A13410@redhat.com>
References: <1024948946.30229.19.camel@turbulence.megapathdsl.net> <3D18A273.284F8EDD@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D18A273.284F8EDD@zip.com.au>; from akpm@zip.com.au on Tue, Jun 25, 2002 at 10:03:47AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 25, 2002 at 10:03:47AM -0700, Andrew Morton
<akpm@zip.com.au> wrote:

> If it's because of the disk-spins-up-too-much problem then
> that can be addressed by allowing the commit interval to be
> set to larger values.

> +int jbd_commit_interval = 5;	/* /proc/sys/fs/jbd_commit_interval */

I suspect you want this to be per-mount, not system-wide (although
filesystems could easily just inherit the system default dynamically
if there's no per-fs override.)  I could easily imagine a user wanting
a different interval for a scratch disk, for example.

Cheers,
 Stephen
