Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280457AbRKEK1t>; Mon, 5 Nov 2001 05:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280452AbRKEK1k>; Mon, 5 Nov 2001 05:27:40 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:21427 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S280457AbRKEK1a>; Mon, 5 Nov 2001 05:27:30 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: dalecki@evision.ag, Martin Dalecki <dalecki@evision-ventures.com>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Date: Mon, 5 Nov 2001 11:28:27 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Tim Jansen <tim@tjansen.de>,
        "Jakob =?iso-8859-1?q?=D8stergaard?=" <jakob@unthought.net>,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.21.0111041321300.21449-100000@weyl.math.psu.edu> <3BE672D1.5E4DBFD2@evision-ventures.com>
In-Reply-To: <3BE672D1.5E4DBFD2@evision-ventures.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011105102724Z16315-18972+86@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 5, 2001 12:06 pm, Martin Dalecki wrote:
> Alexander Viro wrote:
> > At the very least, use canonical bytesex and field sizes.  Anything less
> > is just begging for trouble.  And in case of procfs or its equivalents,
> > _use_ the_ _damn_ _ASCII_ _representations_.  scanf(3) is there for
> > purpose.
> 
> And the purpose of scanf in system level applications is to introduce
> nice opportunities for buffer overruns and string formatting bugs.

I've done quite a bit more kernel profiling and I've found that overhead for 
converting numbers to ascii for transport to proc is significant, and there 
are other overheads as well, such as the sprintf and proc file open.  These 
must be matched by corresponding overhead on the user space side, which I 
have not profiled.  I'll take some time and present these numbers properly at 
some point.

Not that I think we are going to change this way of doing things any time
soon - Linus has spoken - but at least we should know what the overheads are.
Programmers should not labor under the misaprehension that this is an 
efficient interface.

--
Daniel
