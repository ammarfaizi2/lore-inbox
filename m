Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262501AbREUVvb>; Mon, 21 May 2001 17:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262502AbREUVvV>; Mon, 21 May 2001 17:51:21 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:47314 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262504AbREUVvK>;
	Mon, 21 May 2001 17:51:10 -0400
Date: Mon, 21 May 2001 17:51:08 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Pavel Machek <pavel@suse.cz>, Richard Gooch <rgooch@ras.ucalgary.ca>,
        Matthew Wilcox <matthew@wil.cx>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <E151xFO-0000ue-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0105211745490.12245-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 May 2001, Alan Cox wrote:

> > Which, BTW, is a wonderful reason for having multiple channels. Instead
> > of write(fd, "critical_command", 8); read(fd,....); you read from the right fd.
> > Opened before you enter the hotspot. Less overhead than ioctl() would
> > have...
> 
> The ioctl is one syscall, the read/write pair are two. Im not sure that ioctl
> is going to be more overhead there. In the video4linux case the high overhead
> is acking frames received by mmap so might conceivably be considered one way

Sure. But we have to do two syscalls only if ioctl has both in- and out-
arguments that way. Moreover, we are talking about non-trivial in- arguments.
How many of these are in hotspots?

