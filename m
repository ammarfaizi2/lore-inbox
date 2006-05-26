Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030507AbWEZGJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030507AbWEZGJy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 02:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030508AbWEZGJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 02:09:54 -0400
Received: from smtp.enter.net ([216.193.128.24]:1028 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S1030507AbWEZGJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 02:09:53 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: OpenGL-based framebuffer concepts
Date: Fri, 26 May 2006 02:09:42 +0000
User-Agent: KMail/1.8.1
Cc: Jon Smirl <jonsmirl@gmail.com>, Matheus Izvekov <mizvekov@gmail.com>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <9e4733910605240932s61bb124fre3ec217d69956e78@mail.gmail.com> <44768AAD.3030800@ums.usu.ru>
In-Reply-To: <44768AAD.3030800@ums.usu.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605260209.43533.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 26 May 2006 04:57, Alexander E. Patrakov wrote:
> Jon Smirl wrote:
> > Most video hardware (99%) has enough memory to support double
> > buffering. You save it to the other buffer, display the error, and
> > copy it back on enter.
>
> This is possible only if the video memory management is in the kernel.
> Reason: userspace may also want to use double buffering, and we definitely
> want to allocate the "other (maybe third) buffer" somewhere in the free
> video memory. And allocating a lot of system RAM on oops seems to be a very
> bad idea (cascade of oopses may follow).
>
> Also, did anyone measure the video RAM usage during a typical Xgl session
> (i.e.: is there really enough free video RAM, not occupied by various
> caches)?
>
> Although, a Microsoft-ish "lost context, please redraw" solution has been
> already proposed.

In the case of an oops or a panic the system might not be stable enough to 
continue operation.  In fact, I have never had a system experience either and 
still be able to run - even at the console.

In such a case, I think it'd be preferable to overwrite any graphics mode 
currently in use to display the data.  However, there must be some control on 
this, to prevent people from arbitrarily killing the video mode to display 
data.  In any event, seeing the huge ideological split and the inability of 
the people involved with this discussion to agree on a single, clear path for 
the graphics system to take...

Let me put it this way: I may write code for free, but I don't write code 
unless theres a design to it. I joined this conversation to toss a few ideas 
off the top of my head out there and see if any were useful. This has become 
something of a very genial flame war... 

Over the next couple of days I'll work on a few design ideas for a replacement 
to the current, somewhat poorly done graphics core in Linux and post them for 
comments. These will hopefully cover all sides of the currently seen 
ideological split as well as one or two that hopefully span the split.

All of them will be open for comment and revision, and if one of them is 
ultimately agreed on, I'll start work on it. If not, then I'll go back to 
just watching the traffic and hoping someone will finally start fixing the 
problems in the graphics systems.

DRH
