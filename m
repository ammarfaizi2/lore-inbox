Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266808AbRHBSfm>; Thu, 2 Aug 2001 14:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267743AbRHBSfc>; Thu, 2 Aug 2001 14:35:32 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:482 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S266808AbRHBSfV>;
	Thu, 2 Aug 2001 14:35:21 -0400
Date: Thu, 2 Aug 2001 14:35:28 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: intermediate summary of ext3-2.4-0.9.4 thread
In-Reply-To: <20010802193750.B12425@emma1.emma.line.org>
Message-ID: <Pine.GSO.4.21.0108021431050.29563-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 2 Aug 2001, Matthias Andree wrote:

> asynchronous rename/link/unlink/symlink, however a directory fsync() is
> believed to be rather expensive.

How the fuck it's expensive? It does _exactly_ the same as file fsync() -
literally the same code. It doesn't write blocks that don't belong to
directory. It doesn't write blocks that are clean. IOW, it does the
minimal work possible.

