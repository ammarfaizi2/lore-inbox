Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261186AbREOReY>; Tue, 15 May 2001 13:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261159AbREORcs>; Tue, 15 May 2001 13:32:48 -0400
Received: from [206.14.214.140] ([206.14.214.140]:53508 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S261166AbREORa3>; Tue, 15 May 2001 13:30:29 -0400
Date: Tue, 15 May 2001 10:29:59 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.GSO.4.21.0105151323250.21081-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.10.10105151028380.22038-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > What I wish was done was the very first ioctl call was a generic ioctl
> > call to pass driver specific data. Basically you have something like this:
> > 
> > struct fb_driver_specific_data {
> > 	__u32 magic_identifier;
> > 	__u32 size_of_data_packet;
> > 	char *data_buffer;
> > } 
> 
> It's called write(2). magic_identifier: which file we are writing to.
> size_of_data_packet: length. data_buffer: buffer we write from.
> 
> And if write() has too much overhead - we'd better fix _that_, because
> it's much more likely hotspot than ioctl ever will be.

I would use write except we use write to draw into the framebuffer. If I
write to the framebuffer with that data the only thing that will happen is
I will get pretty colors on my screen. 

