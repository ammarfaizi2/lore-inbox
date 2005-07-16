Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVGPSFF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVGPSFF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 14:05:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVGPSFF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 14:05:05 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:28941 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261784AbVGPSFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 14:05:03 -0400
Date: Sat, 16 Jul 2005 19:57:54 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Dhruv Matani <dhruvbird@gmail.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Arvind Kalyan <base16@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: NFS and fifos.
Message-ID: <20050716175754.GQ8907@alpha.home.local>
References: <3a9148b9050716034417d7d148@mail.gmail.com> <90c25f2705071607321d66a776@mail.gmail.com> <3a9148b905071608496f5c9339@mail.gmail.com> <9a87484905071608565d4b2ec1@mail.gmail.com> <3a9148b905071610559f494a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a9148b905071610559f494a3@mail.gmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 16, 2005 at 11:25:01PM +0530, Dhruv Matani wrote:
> On 7/16/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > On 7/16/05, Dhruv Matani <dhruvbird@gmail.com> wrote:
> > > On 7/16/05, Arvind Kalyan <base16@gmail.com> wrote:
> > > > On 7/16/05, Dhruv Matani <dhruvbird@gmail.com> wrote:
> > > > > Hello,
> > > > >   I can't seem to be able to use fifos on an NFS mount. Is there any
> > > > > reason why this is disallowed, or is this is a bug? v.2.4.20.
> > > >
> > > > Are both the processes (reader/writer) on the same machine? FIFOs are
> > > > local objects.
> > >
> > > Yes, but I'm accessing them through my remote[public] IP address.
> > > The idea behind it is to have a fifo that works across the network
> > > through an NFS mount. Is that possible?
> > >
> > > I serched google for 'socket file', and all that I got was 'fifo', but
> > > they are to be used only on a singl machine for communication between
> > > 2 or more applications, but couldn't find any file abstraction for
> > > communication for processes on distinct machines. Do you know of any
> > > such thing, cause I couldn't find any.
> > >
> > 
> > sockets.
> 
> Are sockets named files?

Unix sockets, yes. Look at /dev/log or /tmp/.X11-unix/X0 for example.
But they are local anyway, you cannot use them between two systems.

Willy

