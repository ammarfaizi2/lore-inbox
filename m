Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132056AbRCYQE3>; Sun, 25 Mar 2001 11:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132051AbRCYQEU>; Sun, 25 Mar 2001 11:04:20 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:30986 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S132056AbRCYQEJ>; Sun, 25 Mar 2001 11:04:09 -0500
Date: Sun, 25 Mar 2001 18:12:56 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Jesse Pollard <jesse@cats-chateau.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <Andries.Brouwer@cwi.nl>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <01032411110700.03927@tabby>
Message-ID: <Pine.LNX.4.30.0103251754300.13864-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 24 Mar 2001, Jesse Pollard wrote:
> On Fri, 23 Mar 2001, Alan Cox wrote:
[ .... about non-overcommit .... ]
> > Nobody feels its very important because nobody has implemented it.

Enterprises use other systems because they have much better resource
management than Linux -- adding non-overcommit wouldn't help them much.
Desktop users, Linux newbies don't understand what's
eager/early/non-overcommit vs lazy/late/overcommit memory management
[just see these threads here if you aren't bored already enough ;)] and
even if they do at last they don't have the ability to implement it. And
between them, people are mostly fine with ulimit.

> Small correction - It was implemented, just not included in the standard
> kernel.

Please note, adding optional non-overcommit also wouldn't help much
without guaranteed/reserved resources [e.g. you are OOM -> appps, users
complain, admin login in and BANG OOM killer just killed one of the
jobs]. This was one of the reasons I made the reserved root memory
patch [this is also the way other OS'es do]. Now just the different
patches should be merged and write an OOM FAQ for users how to avoid,
control, etc it].

	Szaka

