Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269517AbRHCTi6>; Fri, 3 Aug 2001 15:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269527AbRHCTis>; Fri, 3 Aug 2001 15:38:48 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:12534 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269517AbRHCTig>;
	Fri, 3 Aug 2001 15:38:36 -0400
Date: Fri, 3 Aug 2001 15:38:44 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Morton <akpm@zip.com.au>
cc: Greg Louis <glouis@dynamicro.on.ca>, ext3-users <ext3-users@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: ac4 ext3 recovery failure
In-Reply-To: <3B6AFBD1.5F43B496@zip.com.au>
Message-ID: <Pine.GSO.4.21.0108031534210.3272-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Aug 2001, Andrew Morton wrote:

> Do you think this happened during the e2fsck run, or during the
> actual mount?

actual mount. s/fsync_dev/fsync_no_super/ in fs/jbd/*. Already fixed
in Alan's tree.

BTW, code around the place in question looks somewhat fishy - looks
like you have a lot of stuff assuming that journal and fs are on the
same device.

