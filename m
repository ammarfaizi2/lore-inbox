Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318342AbSHKT7M>; Sun, 11 Aug 2002 15:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318344AbSHKT7M>; Sun, 11 Aug 2002 15:59:12 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:42484 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318342AbSHKT7M>; Sun, 11 Aug 2002 15:59:12 -0400
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Paul Larson <plars@austin.ibm.com>,
       Hubertus Franke <frankeh@us.ibm.com>,
       Rik van Riel <riel@conectiva.com.br>, Andries Brouwer <aebr@win.tue.nl>,
       Andrew Morton <akpm@zip.com.au>, andrea@suse.de,
       Dave Jones <davej@suse.de>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020811205847.A3206@kushida.apsleyroad.org>
References: <20020810182317.A306@kushida.apsleyroad.org>
	<Pine.LNX.4.44.0208101132490.2197-100000@home.transmeta.com>
	<20020810194813.D306@kushida.apsleyroad.org>
	<1029098474.16236.58.camel@irongate.swansea.linux.org.uk> 
	<20020811205847.A3206@kushida.apsleyroad.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 11 Aug 2002 22:23:58 +0100
Message-Id: <1029101038.16424.74.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-11 at 20:58, Jamie Lokier wrote:
> Alan Cox wrote:
> > If they hold both handles open and stat them and find the same inode
> > number then yes its a bug. We have lots of room for inode numbers to
> > handle 2^30 processes and allow for 2^30 other files
> 
> So, in general, the way to detect hard links requires both objects to be
> open at the same time?  I was sure it was enough to stat(), and check
> (st1.st_ino == st2.st_ino && st1.st_dev == st2.st_dev).
> 
> Admittedly, one of the object could be renamed or deleted in that time
> so it's not 100% reliable on changing filesystems.

Hence you need both open at the same time. 
