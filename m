Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280448AbRKEKO3>; Mon, 5 Nov 2001 05:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280449AbRKEKOS>; Mon, 5 Nov 2001 05:14:18 -0500
Received: from [195.63.194.11] ([195.63.194.11]:54279 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S280448AbRKEKOC>; Mon, 5 Nov 2001 05:14:02 -0500
Message-ID: <3BE672D1.5E4DBFD2@evision-ventures.com>
Date: Mon, 05 Nov 2001 12:06:57 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Tim Jansen <tim@tjansen.de>, Daniel Phillips <phillips@bonn-fries.net>,
        "Jakob =?iso-8859-1?Q?=D8stergaard?=" <jakob@unthought.net>,
        linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
In-Reply-To: <Pine.GSO.4.21.0111041321300.21449-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Sun, 4 Nov 2001, Tim Jansen wrote:
> 
> > So if only some programs use the 'dot-files' and the other still use the
> > crappy text interface we still have the old problem for scripts, only with a
> > much larger effort.
> 
> Folks, could we please deep-six the "ASCII is tough" mentality?  Idea of
> native-endian data is so broken that it's not even funny.  Exercise:
> try to export such thing over the network.  Another one: try to use
> that in a shell script.  One more: try to do it portably in Perl script.
> 
> It had been tried.  Many times.  It had backfired 100 times out 100.
> We have the same idiocy to thank for fun trying to move a disk with UFS
> volume from Solaris sparc to Solaris x86.  We have the same idiocy to
> thank for a lot of ugliness in X.
> 
> At the very least, use canonical bytesex and field sizes.  Anything less
> is just begging for trouble.  And in case of procfs or its equivalents,
> _use_ the_ _damn_ _ASCII_ _representations_.  scanf(3) is there for
> purpose.

And the purpose of scanf in system level applications is to introduce
nice
opportunities for buffer overruns and string formatting bugs.
