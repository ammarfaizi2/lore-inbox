Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261155AbREORcx>; Tue, 15 May 2001 13:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261182AbREORcn>; Tue, 15 May 2001 13:32:43 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:33725 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261155AbREORZ6>;
	Tue, 15 May 2001 13:25:58 -0400
Date: Tue, 15 May 2001 13:25:56 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: James Simmons <jsimmons@transvirtual.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.10.10105151002410.22038-100000@www.transvirtual.com>
Message-ID: <Pine.GSO.4.21.0105151323250.21081-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 May 2001, James Simmons wrote:

> What I wish was done was the very first ioctl call was a generic ioctl
> call to pass driver specific data. Basically you have something like this:
> 
> struct fb_driver_specific_data {
> 	__u32 magic_identifier;
> 	__u32 size_of_data_packet;
> 	char *data_buffer;
> } 

It's called write(2). magic_identifier: which file we are writing to.
size_of_data_packet: length. data_buffer: buffer we write from.

And if write() has too much overhead - we'd better fix _that_, because
it's much more likely hotspot than ioctl ever will be.

