Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129696AbRCAU4R>; Thu, 1 Mar 2001 15:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129981AbRCAU4I>; Thu, 1 Mar 2001 15:56:08 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:53381 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129696AbRCAUzw>;
	Thu, 1 Mar 2001 15:55:52 -0500
Date: Thu, 1 Mar 2001 15:54:25 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Pavel Machek <pavel@suse.cz>
cc: Bill Crawford <billc@netcomuk.co.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Daniel Phillips <phillips@innominate.de>
Subject: Re: Hashing and directories
In-Reply-To: <20000101020213.D28@(none)>
Message-ID: <Pine.GSO.4.21.0103011547200.11577-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 1 Jan 2000, Pavel Machek wrote:

> Hi!
> 
> >  I was hoping to point out that in real life, most systems that
> > need to access large numbers of files are already designed to do
> > some kind of hashing, or at least to divide-and-conquer by using
> > multi-level directory structures.
> 
> Yes -- because their workaround kernel slowness.

Pavel, I'm afraid that you are missing the point. Several, actually:
	* limits of _human_ capability to deal with large unstructured
sets of objects
	* userland issues (what, you thought that limits on the
command size will go away?)
	* portability

The point being: applications and users _do_ know better what structure
is there. Kernel can try to second-guess them and be real good at that, but
inability to second-guess is the last of the reasons why aforementioned
strategies are used. 

