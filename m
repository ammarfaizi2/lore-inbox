Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272604AbRHaEqc>; Fri, 31 Aug 2001 00:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272605AbRHaEqW>; Fri, 31 Aug 2001 00:46:22 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:52945 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S272604AbRHaEqH>;
	Fri, 31 Aug 2001 00:46:07 -0400
Date: Fri, 31 Aug 2001 00:46:24 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Kevin P. Fleming" <kevin@labsysgrp.com>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.9-ac1/2/3 allows multiple mounts of NFS filesystem on same
 mountpoint
In-Reply-To: <001301c131d4$de9180f0$6caaa8c0@kevin>
Message-ID: <Pine.GSO.4.21.0108310043320.11975-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 Aug 2001, Kevin P. Fleming wrote:

> I was expecting it to be an error, but I'm not upset that it's not. Just
> kind of weird to see five mounts with the exact same information in
> /etc/mtab.
> 
> I can see why it would be useful to have multiple things mounted on the same
> mountpoint, but is there any reason to allow the _same_ filesystem to be
> mounted multiple times at the same mountpoint?

How do you tell if it's the same filesystem?  Frankly, I'd rather get rid of
mounting several things at one mountpoint, different or not - that would
make life much easier, but it means that we need to implement mount-traps
to make autofs folks happy.  It _may_ be doable in 2.4, but I susupect that
it will end up as 2.5 project.

