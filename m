Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273796AbRKDTRd>; Sun, 4 Nov 2001 14:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273881AbRKDTRO>; Sun, 4 Nov 2001 14:17:14 -0500
Received: from humbolt.nl.linux.org ([131.211.28.48]:42409 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S273796AbRKDTRG>; Sun, 4 Nov 2001 14:17:06 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Daniel Phillips <phillips@bonn-fries.net>
To: Jakob =?iso-8859-1?q?=D8stergaard?= <jakob@unthought.net>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Date: Sun, 4 Nov 2001 20:18:11 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Tim Jansen <tim@tjansen.de>, linux-kernel@vger.kernel.org
In-Reply-To: <160Rpw-0rLDCyC@fmrl05.sul.t-online.com> <Pine.GSO.4.21.0111041321300.21449-100000@weyl.math.psu.edu> <20011104195209.J14001@unthought.net>
In-Reply-To: <20011104195209.J14001@unthought.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011104191700Z16935-23341+14@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 4, 2001 07:52 pm, Jakob Østergaard wrote:
> On Sun, Nov 04, 2001 at 01:30:38PM -0500, Alexander Viro wrote:
> > Folks, could we please deep-six the "ASCII is tough" mentality?  Idea of
> > native-endian data is so broken that it's not even funny.  Exercise:
> > try to export such thing over the network.  Another one: try to use
> > that in a shell script.  One more: try to do it portably in Perl script.
> 
> So make it network byte order.
> 
> How many bugs have you heard of with bad use of sscanf() ?

Yes, and it's easy for those to be buffer overflow bugs.  The extra security 
risk is even more of a reason to avoid ASCII strings in internal interfaces 
than the gross overhead.  Do the ASCII conversions in user space, please.

No, ASCII isn't tough, it just sucks as an internal transport.

--
Daniel
