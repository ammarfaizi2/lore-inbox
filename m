Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277237AbRJVRuI>; Mon, 22 Oct 2001 13:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277246AbRJVRt6>; Mon, 22 Oct 2001 13:49:58 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:7856 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277237AbRJVRtr>;
	Mon, 22 Oct 2001 13:49:47 -0400
Date: Mon, 22 Oct 2001 13:50:13 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_misc.c, kernel-2.4.12
In-Reply-To: <3BD45631.78C4D16F@zip.com.au>
Message-ID: <Pine.GSO.4.21.0110221348010.4117-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Oct 2001, Andrew Morton wrote:

> Why is it necessary that the new binfmt_misc create its own
> filesystem type, when all it seems to need is a couple of
> /proc entries?

If it was so nice...  It needs to create and remove them upon
write(2).  And doing that correctly via procfs is _not_ pretty.
The damn thing is very bad at doing dynamic contents and when
mixed with API of that weirdness...

