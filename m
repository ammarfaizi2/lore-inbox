Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277802AbRJRQcC>; Thu, 18 Oct 2001 12:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277798AbRJRQbw>; Thu, 18 Oct 2001 12:31:52 -0400
Received: from schroeder.cs.wisc.edu ([128.105.6.11]:60169 "EHLO
	schroeder.cs.wisc.edu") by vger.kernel.org with ESMTP
	id <S277792AbRJRQbl>; Thu, 18 Oct 2001 12:31:41 -0400
Message-Id: <200110181632.f9IGW9i29729@schroeder.cs.wisc.edu>
Content-Type: text/plain; charset=US-ASCII
From: Nick LeRoy <nleroy@cs.wisc.edu>
Organization: UW Condor
To: Ville Herva <vherva@niksula.hut.fi>, Kamil Iskra <kamil@science.uva.nl>
Subject: Re: Poor floppy performance in kernel 2.4.10
Date: Thu, 18 Oct 2001 11:30:17 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011018092837.C1144@turbolinux.com> <Pine.LNX.4.33.0110181734270.7583-100000@krakow.science.uva.nl> <20011018191732.B1262@niksula.cs.hut.fi>
In-Reply-To: <20011018191732.B1262@niksula.cs.hut.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 October 2001 11:17, Ville Herva wrote:

(snip)
> That's propably beacause it syncs the writes on close().
>
> Perhaps you could try the trick Linus suggested in another thread, namely:
>
> sleep 1000 < /dev/fd0 &
>
> mdir
> mcopy
> mdir
> mcopy
> <do whatever>
>
> kill %1
>
> That keeps one (dummy) reference to the floppy device open until you're
> done using it.

Perhaps there should be a pair of "mtools" added: mopen and mclose, that do 
basically this.  That way it could be a "standard" item, documented in man 
pages, etc., not some secret that only the l-k users know.  Thoughts?

-Nick
