Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261493AbREXLRN>; Thu, 24 May 2001 07:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261473AbREXLRE>; Thu, 24 May 2001 07:17:04 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:62217 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261459AbREXLQu>; Thu, 24 May 2001 07:16:50 -0400
Date: Thu, 24 May 2001 11:35:39 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Andries.Brouwer@cwi.nl, helgehaf@idb.hist.no, linux-kernel@vger.kernel.org,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] struct char_device
Message-ID: <20010524113539.K27177@redhat.com>
In-Reply-To: <UTC200105231334.PAA86145.aeb@vlet.cwi.nl> <Pine.GSO.4.21.0105231351360.20269-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0105231351360.20269-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, May 23, 2001 at 01:54:15PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 23, 2001 at 01:54:15PM -0400, Alexander Viro wrote:
> On Wed, 23 May 2001 Andries.Brouwer@cwi.nl wrote:
> 
> > > But I don't want an initrd.
> > Don't be afraid of words. You wouldnt notice - it would do its
> > job and disappear just like piggyback today.
> 
> Andries, initrd code is _sick_. Our boot sequence is not a wonder of
> elegance, but that crap is the worst part. I certainly can understand
> people not wanting to use that on aesthetical reasons alone.

It's the principle of a kernel-linked boot image, not initrd, which is
important.  Unpacking a cramfs image from an __init section is much
cleaner than initrd and has almost the same effect: the boot
filesystem just ends up readonly that way.  Either way we can hook
in that default user-space code at boot time transparently.

--Stephen
