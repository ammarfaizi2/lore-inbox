Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262374AbREUUmR>; Mon, 21 May 2001 16:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262375AbREUUmJ>; Mon, 21 May 2001 16:42:09 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:29428 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S262356AbREUUlu>;
	Mon, 21 May 2001 16:41:50 -0400
Date: Mon, 21 May 2001 16:41:48 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Pavel Machek <pavel@suse.cz>, Richard Gooch <rgooch@ras.ucalgary.ca>,
        Matthew Wilcox <matthew@wil.cx>, Andrew Clausen <clausen@gnu.org>,
        Ben LaHaise <bcrl@redhat.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFD w/info-PATCH] device arguments from lookup, partion code
In-Reply-To: <E151wAN-0000pE-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0105211639250.12245-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 May 2001, Alan Cox wrote:

> > > I don't need to read it. Don't be insulting. Sure, you *can* use a
> > > write(2)/read(2) cycle. But that's two syscalls compared to one with
> > > ioctl(2) or transaction(2). That can matter to some applications.
> > 
> > I just don't think so. Where did you see performance-critical use of
> > ioctl()?
> 
> AGP, video4linux,...

Which, BTW, is a wonderful reason for having multiple channels. Instead
of write(fd, "critical_command", 8); read(fd,....); you read from the right fd.
Opened before you enter the hotspot. Less overhead than ioctl() would
have...

