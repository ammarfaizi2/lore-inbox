Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261651AbTCVAl0>; Fri, 21 Mar 2003 19:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261652AbTCVAl0>; Fri, 21 Mar 2003 19:41:26 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:31241 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261651AbTCVAlW>; Fri, 21 Mar 2003 19:41:22 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Date: 21 Mar 2003 16:51:51 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b5gc37$2bg$1@cesium.transmeta.com>
References: <Pine.LNX.4.44.0303161341520.5348-100000@xanadu.home> <20030321141620.GA25142@work.bitmover.com> <b5fpra$rdb$1@cesium.transmeta.com> <20030322001540.GA6309@work.bitmover.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030322001540.GA6309@work.bitmover.com>
By author:    Larry McVoy <lm@bitmover.com>
In newsgroup: linux.dev.kernel
>
> On Fri, Mar 21, 2003 at 11:40:26AM -0800, H. Peter Anvin wrote:
> > Followup to:  <20030321141620.GA25142@work.bitmover.com>
> > By author:    Larry McVoy <lm@bitmover.com>
> > In newsgroup: linux.dev.kernel
> > > 
> > > HPA, should we be mirroring the CVS tarballs to kernel.org?
> > > 
> > 
> > That would be highly useful.  I would also like to see the bk export
> > text file, whatever it's called, mirrored there.
> 
> There is no bk export text file, the output of the export is the CVS
> repository, there isn't anything else.  Everything that we could 
> extract has been extracted and put in CVS.  It's a fairly complete
> and accurate extraction, too.  Far more than the traditional releases
> and pre-releases, I don't know how many of those there have been in
> the 2.5 timeframe but I can't imagine more than a couple hundred;
> there are 8500 commits in the 2.5 CVS tree.  
> 

I was referring to this stuff:

Date: 	Wed, 12 Mar 2003 10:03:04 -0800
X-Hdr-Sender: lm@bitmover.com
From: Larry McVoy <lm@bitmover.com>
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030312180304.GA30788@work.bitmover.com>
References: <3E6F6E84.1010601@zytor.com> <200303121757.h2CHveVF001517@81-2-122-30.bradfords.org.uk>

> I thought that BK has been able to export everything to a text file
> since the first version.

bk export -tpatch -r1.900 > patch.1.900
bk changes -v -r1.900 > comments.1.900

Been there forever.  So has ways to get all the metadata from the command
line without having to reverse engineer the file format.  See

    http://www.bitkeeper.com/manpages/bk-prs-1.html

it's all there.  Always has been.

Wayne wanted me to point that it is easy to write the BK to CVS exporter
completely from the command line, we prototyped it that way, the only
reason we rewrote part of it in C was for performance.  The point being
that you guys could have done this yourself without help from us because
all the metadata is right there.  Ditto for anyone else worried about 
getting their data out of BK now or in the future.  The whole point of
prs is to be able to have a will-always-work way to get at the data or
the metadata, it makes the file format a non-issue.  
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
