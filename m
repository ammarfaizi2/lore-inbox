Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279603AbRKDWyi>; Sun, 4 Nov 2001 17:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279811AbRKDWy1>; Sun, 4 Nov 2001 17:54:27 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:14893 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S279603AbRKDWyV> convert rfc822-to-8bit; Sun, 4 Nov 2001 17:54:21 -0500
Message-Id: <4.3.2.7.2.20011104144813.00c2c360@10.1.1.42>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sun, 04 Nov 2001 14:53:54 -0800
To: Jakob =?iso-8859-1?Q?=D8stergaard?= <jakob@unthought.net>,
        Tim Jansen <tim@tjansen.de>
From: Stephen Satchell <satch@concentric.net>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011104211153.V14001@unthought.net>
In-Reply-To: <160TbB-1wNIOWC@fmrl04.sul.t-online.com>
 <E15zF9H-0000NL-00@wagner>
 <160T6C-1RvGb2C@fmrl05.sul.t-online.com>
 <20011104205527.R14001@unthought.net>
 <160TbB-1wNIOWC@fmrl04.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:11 PM 11/4/01 +0100, Jakob Østergaard wrote:
>On Sun, Nov 04, 2001 at 09:13:35PM +0100, Tim Jansen wrote:
> > On Sunday 04 November 2001 20:55, Jakob Østergaard wrote:
> > > > BTW nobody says to one-value-files can not have types (see my earlier
> > > > posts in this thread).
> > > I don't dislike one-value-files - please tell me how you get type
> > > information
> >
> > Using a ioctl that returns the type.
>
>But that's not pretty   :)
>
>Can't we think of something else ?

I absolutely love how people want to re-invent the wheel.  If you want 
typed access (both read AND write) in a version-independent manner, then 
you really need to take a look at Simple Network Management Protocol, or 
SNMP.  It has everything you want:  named access, types, binary data or 
ASCII data or whatever data, and the ability for vendor, distribution, and 
version differences to be caught quickly and easily.  As new stuff is added 
or changed, all you need is a replacement MIB to be able to use the stuff.

Furthermore, SNMP is script friendly in that access to the data can be 
automated, with all conversions being done in userspace.

Finally, SNMP works over networks.

There are many, many security issues surrounding SNMP, but at least it 
exists, is well-understood, is already implemented in multiple systems, and 
it WORKS.

Why invent yet another replacement for sysctl?

My pair-o-pennies(tm) to this discussion...

Satch

