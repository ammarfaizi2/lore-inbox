Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261193AbREORpD>; Tue, 15 May 2001 13:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261192AbREORom>; Tue, 15 May 2001 13:44:42 -0400
Received: from [206.14.214.140] ([206.14.214.140]:61444 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S261191AbREORof>; Tue, 15 May 2001 13:44:35 -0400
Date: Tue, 15 May 2001 10:44:23 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.GSO.4.21.0105151330480.21081-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10105151036490.22038-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I would use write except we use write to draw into the framebuffer. If I
> > write to the framebuffer with that data the only thing that will happen is
> > I will get pretty colors on my screen. 
> 
> Yes. And we also use write to send data to printer. So what? Nobody makes
> you use the same file.

Well creating a new device wouldn't make linus happen right now. I do
agree ioctl calls are evil!!!! You only have X amount of them. With write
you can have infinte amounts of different functions to perform on a
device. I didn't design fbdev :-( If I did it would have been far
different. I do plan on some day merging drm and fbdev into one interface. So
I plan to change this behavior. I like to see this interface ioctl-less
(is their such a word ???). You mmap to alter buffers. Mmap is much more
flexiable than write for graphics buffers anyways. You use write to pass
"data" to the driver.

