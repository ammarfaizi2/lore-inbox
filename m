Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318345AbSHKUIc>; Sun, 11 Aug 2002 16:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318347AbSHKUIc>; Sun, 11 Aug 2002 16:08:32 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:46284 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S318345AbSHKUIc>; Sun, 11 Aug 2002 16:08:32 -0400
Date: Sun, 11 Aug 2002 21:10:24 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Paul Larson <plars@austin.ibm.com>,
       Hubertus Franke <frankeh@us.ibm.com>,
       Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       Andrew Morton <akpm@zip.com.au>, andrea@suse.de,
       Dave Jones <davej@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
Message-ID: <20020811211024.C3206@kushida.apsleyroad.org>
References: <20020810182317.A306@kushida.apsleyroad.org> <Pine.LNX.4.44.0208101132490.2197-100000@home.transmeta.com> <20020810194813.D306@kushida.apsleyroad.org> <1029098474.16236.58.camel@irongate.swansea.linux.org.uk> <20020811205847.A3206@kushida.apsleyroad.org> <1029101038.16424.74.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1029101038.16424.74.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Sun, Aug 11, 2002 at 10:23:58PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > So, in general, the way to detect hard links requires both objects to be
> > open at the same time?  I was sure it was enough to stat(), and check
> > (st1.st_ino == st2.st_ino && st1.st_dev == st2.st_dev).
> > 
> > Admittedly, one of the object could be renamed or deleted in that time
> > so it's not 100% reliable on changing filesystems.
> 
> Hence you need both open at the same time. 

... unless you know that what you're looking at isn't changing, or you
only guarantee correct results for parts of the filesystem which don't
change (`tar', `find' etc.)

Again, /proc is exempt! :)

-- Jamie
