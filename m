Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130457AbRCGJLi>; Wed, 7 Mar 2001 04:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130460AbRCGJL3>; Wed, 7 Mar 2001 04:11:29 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:49634 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130457AbRCGJLN>;
	Wed, 7 Mar 2001 04:11:13 -0500
Date: Wed, 7 Mar 2001 04:10:31 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Abramo Bagnara <abramo@alsa-project.org>
cc: Jeremy Elson <jelson@circlemud.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Mapping a piece of one process' addrspace to another?
In-Reply-To: <3AA5F983.D963D199@alsa-project.org>
Message-ID: <Pine.GSO.4.21.0103070409410.2127-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 7 Mar 2001, Abramo Bagnara wrote:

> Alexander Viro wrote:
> > 
> > On Wed, 7 Mar 2001, Jeremy Elson wrote:
> > 
> > > Right now, my code looks something like this: (it might make more
> > > sense if you know that I've written a framework for writing user-space
> > > device drivers... I'm going to be releasing it soon, hopefully after I
> > > resolve this performance problem.  Or maybe before, if it's hard.)
> > 
> > Ugh. Why not make that a named pipe and use zerocopy stuff for pipes?
> > I.e. why bother with making it look like a character device rather than
> > a FIFO?
> 
> What about ioctl? Device drivers sometimes need it ;-)

No, they don't. OOB data is equivalent to data on parallel channel.

