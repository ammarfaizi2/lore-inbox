Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263648AbRFASFz>; Fri, 1 Jun 2001 14:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263658AbRFASFp>; Fri, 1 Jun 2001 14:05:45 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:64206 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263648AbRFASF2>;
	Fri, 1 Jun 2001 14:05:28 -0400
Date: Fri, 1 Jun 2001 14:05:26 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Hans Reiser <reiser@namesys.com>
cc: thunder7@xs4all.nl, linux-kernel@vger.kernel.org
Subject: Re: unmount issues with 2.4.5-ac5, 3ware, and ReiserFS (was: 
 kernel-2.4.5
In-Reply-To: <3B17CC8E.64AA2BDE@namesys.com>
Message-ID: <Pine.GSO.4.21.0106011403330.22344-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 1 Jun 2001, Hans Reiser wrote:

> known VFS bug, ask viro for details, 2.4.5 is not stable because of it, use
> 2.4.4

Different issue. Missing lock_kernel()/unlock_kernel() in kill_super()
appeared in -pre6 and was fixed in -ac2 or so. -ac5 apparently had
introduced something new, that had been reverted (fixing the problem)
in -ac6.

