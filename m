Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318153AbSHKTQk>; Sun, 11 Aug 2002 15:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318237AbSHKTQk>; Sun, 11 Aug 2002 15:16:40 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:33524 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318153AbSHKTQj>; Sun, 11 Aug 2002 15:16:39 -0400
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Paul Larson <plars@austin.ibm.com>,
       Hubertus Franke <frankeh@us.ibm.com>,
       Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       Andrew Morton <akpm@zip.com.au>, andrea@suse.de,
       Dave Jones <davej@suse.de>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020810194813.D306@kushida.apsleyroad.org>
References: <20020810182317.A306@kushida.apsleyroad.org>
	<Pine.LNX.4.44.0208101132490.2197-100000@home.transmeta.com> 
	<20020810194813.D306@kushida.apsleyroad.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 11 Aug 2002 21:41:14 +0100
Message-Id: <1029098474.16236.58.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-08-10 at 19:48, Jamie Lokier wrote:
> Linus Torvalds wrote:
> > > Oh dear -- what of programs that assume duplicate inode numbers are hard
> > > links, and therefore assume the same contents will be found in each
> > > duplicate?
> > 
> > Well, anybody who tries to back up /proc with "tar" is in for some 
> > surprises anyway ;)
> 
> I was thinking of an over-intelligent `find'.  But hey, as long as this
> is only for the weird and wonderful /proc :-)

If they hold both handles open and stat them and find the same inode
number then yes its a bug. We have lots of room for inode numbers to
handle 2^30 processes and allow for 2^30 other files

