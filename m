Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266153AbSKLH6N>; Tue, 12 Nov 2002 02:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266278AbSKLH6N>; Tue, 12 Nov 2002 02:58:13 -0500
Received: from thunk.org ([140.239.227.29]:23978 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S266153AbSKLH6M>;
	Tue, 12 Nov 2002 02:58:12 -0500
Date: Tue, 12 Nov 2002 03:04:18 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Alexander Viro <viro@math.psu.edu>
Cc: Ryan Anderson <ryan@michonline.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] devfs API
Message-ID: <20021112080417.GA11660@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Alexander Viro <viro@math.psu.edu>,
	Ryan Anderson <ryan@michonline.com>, linux-kernel@vger.kernel.org
References: <20021112013244.GF1729@mythical.michonline.com> <Pine.GSO.4.21.0211112039430.29617-100000@steklov.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0211112039430.29617-100000@steklov.math.psu.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2002 at 08:49:22PM -0500, Alexander Viro wrote:
> The only way I'll use devfs is
> 	* on a separate testbox devoid of network interfaces
> 	* with no users
> 	* with no data - disk periodically populated from image on CD.
> 
> And that's regardless of that cleanup - fixing the interface doesn't solve
> the internal races, so...

Hi Al,

It's good that you're trying to clean up the devfs code, but...

How many people are actually using devfs these days?  I don't like it
myself, and I've had to add a fair amount of hair to fsck's
mount-by-label/uuid code to deal with interesting cases such as
kernels where devfs is configured, but not actually mounted (it
changes what /proc/partitions exports).  So I'm one of those who have
never looked all that kindly on devfs, which shouldn't come as a
surprise to most folks.

In any case, if there aren't all that many people using devfs, I can
think of a really easy way in which we could simplify and clean up its
API by slimming it down by 100%......

						- Ted
