Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129994AbRAFExA>; Fri, 5 Jan 2001 23:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130282AbRAFEwu>; Fri, 5 Jan 2001 23:52:50 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:27618 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129994AbRAFEwe>;
	Fri, 5 Jan 2001 23:52:34 -0500
Date: Fri, 5 Jan 2001 23:52:31 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Stefan Traby <stefan@hello-penguin.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
In-Reply-To: <20010106054615.A2958@stefan.sime.com>
Message-ID: <Pine.GSO.4.21.0101052350460.25336-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Jan 2001, Stefan Traby wrote:

> Then I tried to unlink the file by running rm lfs.file log.
> 
> The rm process (and an ls process that I started after that)
> are now in "D" state...
> 
> root      2934  0.0  0.2  1292  452 pts/5    D    05:38   0:00 ls /ramfs
> root      2952  0.0  1.5  4028 2384 pts/3    S    05:40   0:00 vi sdlkhfd

Add UnlockPage(page) at the end of ramfs_writepage().

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
