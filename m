Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315513AbSGVC3D>; Sun, 21 Jul 2002 22:29:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315536AbSGVC3D>; Sun, 21 Jul 2002 22:29:03 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44551 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315513AbSGVC3D>;
	Sun, 21 Jul 2002 22:29:03 -0400
Message-ID: <3D3B7085.DADED6F@zip.com.au>
Date: Sun, 21 Jul 2002 19:40:05 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Rik van Riel <riel@conectiva.com.br>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/13] minimal rmap
References: <Pine.LNX.4.44L.0207171639480.12241-100000@imladris.surriel.com> <E17Uuti-0004PT-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> ...
> I think Andrew also mentioned he sees a lot of buffers sitting around
> in the morning.  His strip-buffers-immediately hack would kill that
> one dead.

Nope.  It was all inodes and dentries.

`buffermem' accounting went away in 2.5 altogether.  And the
zillions-of-buffer_heads problems should be greatly improved
because a) they're half the size of 2.4's bhs and b) we
no longer attach buffer_heads for reads.

-
