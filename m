Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316144AbSETREQ>; Mon, 20 May 2002 13:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316145AbSETREN>; Mon, 20 May 2002 13:04:13 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:46481 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S316144AbSETREJ>; Mon, 20 May 2002 13:04:09 -0400
Message-Id: <5.1.0.14.2.20020520094738.068778a0@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 20 May 2002 10:03:49 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, jt@hpl.hp.com
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: Question : Broadcast Inter Process Communication ?
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux kernel mailing list)
In-Reply-To: <E178uoc-0007q4-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >       That's exactly why I don't want to deal with it myself.
> >       However, the kernel deal with it all the time, and do it
> > well. For example RtNetlink event have this property (except that they
> > are kernel => process instead of beeing process => process).
>
>By sending one copy of the message to each target. Its how everyone does
>it except for special cases. Reliable multi-delivery is -hard-

I was gonna suggest the same thing. Why not just have a simple event server 
based on unix sockets.
This server would listen on unix stream socket. Clients interested in 
events would connect to it.
All the server has to do is copy event to all connected clients.
Server code is very simple. About 20 lines, everything in a single thread, 
if you use GLib's event loop.

Max 

