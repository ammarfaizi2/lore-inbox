Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263567AbRFRGdr>; Mon, 18 Jun 2001 02:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263625AbRFRGdg>; Mon, 18 Jun 2001 02:33:36 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:48582 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S263567AbRFRGdV>;
	Mon, 18 Jun 2001 02:33:21 -0400
Date: Mon, 18 Jun 2001 02:33:17 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: linux-kernel@vger.kernel.org, devfs-announce-list@vindaloo.ras.ucalgary.ca
Subject: Re: [PATCH] devfs v181 available
In-Reply-To: <200106180601.f5I613D29992@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.GSO.4.21.0106180228180.17131-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Jun 2001, Richard Gooch wrote:

> - Widened locking in <devfs_readlink> and <devfs_follow_link>

No, you hadn't. Both vfs_readlink() and vfs_follow_link() are blocking
functions, so BKL is worthless there.

