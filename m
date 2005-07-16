Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261929AbVGPUrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbVGPUrJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 16:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVGPUrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 16:47:09 -0400
Received: from zproxy.gmail.com ([64.233.162.199]:48955 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261929AbVGPUrH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 16:47:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fXs4mHFH+yuEuD0gGOpJ2sCzuWHUij6GJ1Kbhr7z7IOxI2hsZNQ2gApxYyxHfDWzpsKOKLSMvgKfTSS/u++mFjZS5I1/jGAO89b9S4kOTaP8wfdsMB0Igs9/VLu8opfhH8YV/AmaWgHzdBSF6r4hxfwjof5IEz5CuE+XX7aMXDc=
Message-ID: <9a874849050716134767693099@mail.gmail.com>
Date: Sat, 16 Jul 2005 22:47:07 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: NFS and fifos.
Cc: Dhruv Matani <dhruvbird@gmail.com>, Arvind Kalyan <base16@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050716175754.GQ8907@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3a9148b9050716034417d7d148@mail.gmail.com>
	 <90c25f2705071607321d66a776@mail.gmail.com>
	 <3a9148b905071608496f5c9339@mail.gmail.com>
	 <9a87484905071608565d4b2ec1@mail.gmail.com>
	 <3a9148b905071610559f494a3@mail.gmail.com>
	 <20050716175754.GQ8907@alpha.home.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/05, Willy Tarreau <willy@w.ods.org> wrote:
> On Sat, Jul 16, 2005 at 11:25:01PM +0530, Dhruv Matani wrote:
> > On 7/16/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> > > On 7/16/05, Dhruv Matani <dhruvbird@gmail.com> wrote:
> > > > On 7/16/05, Arvind Kalyan <base16@gmail.com> wrote:
> > > > > On 7/16/05, Dhruv Matani <dhruvbird@gmail.com> wrote:
> > > > > > Hello,
> > > > > >   I can't seem to be able to use fifos on an NFS mount. Is there any
> > > > > > reason why this is disallowed, or is this is a bug? v.2.4.20.
> > > > >
> > > > > Are both the processes (reader/writer) on the same machine? FIFOs are
> > > > > local objects.
> > > >
> > > > Yes, but I'm accessing them through my remote[public] IP address.
> > > > The idea behind it is to have a fifo that works across the network
> > > > through an NFS mount. Is that possible?
> > > >
> > > > I serched google for 'socket file', and all that I got was 'fifo', but
> > > > they are to be used only on a singl machine for communication between
> > > > 2 or more applications, but couldn't find any file abstraction for
> > > > communication for processes on distinct machines. Do you know of any
> > > > such thing, cause I couldn't find any.
> > > >
> > >
> > > sockets.
> >
> > Are sockets named files?
> 
> Unix sockets, yes. Look at /dev/log or /tmp/.X11-unix/X0 for example.
> But they are local anyway, you cannot use them between two systems.
> 
And for communicating between two systems TCP or UDP sockets work just fine.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
