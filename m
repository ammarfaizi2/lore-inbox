Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267176AbUIORVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267176AbUIORVc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 13:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266876AbUIORS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 13:18:57 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:10060 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S266901AbUIORQH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:16:07 -0400
To: =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Being more anal about iospace accesses..
X-Message-Flag: Warning: May contain useful information
References: <Pine.LNX.4.58.0409081543320.5912@ppc970.osdl.org>
	<Pine.LNX.4.58.0409150737260.2333@ppc970.osdl.org>
	<Pine.LNX.4.58.0409150859100.2333@ppc970.osdl.org>
	<20040915165450.GD6158@wohnheim.fh-wedel.de>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 15 Sep 2004 10:16:05 -0700
In-Reply-To: <20040915165450.GD6158@wohnheim.fh-wedel.de> 
 =?iso-8859-1?q?=28J=F6rn?= Engel's message of "Wed, 15 Sep 2004 18:54:50 +0200")
Message-ID: <524qlzxxka.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 15 Sep 2004 17:16:05.0400 (UTC) FILETIME=[AEFCC180:01C49B47]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Jörn> C now supports pointer arithmetic with void*?  I hope the
    Jörn> width of a void is not architecture dependent, that would
    Jörn> introduce more subtle bugs.

Pointer arithmetic on void * has been a gcc extension since forever
(gcc acts as though sizeof (void) == 1).

However, I somewhat agree -- it's ugly for drivers rely on this and do
arithmetic on void *.  It should be OK for a driver to use 
char __iomem * for its IO base if it needs to add in offsets, right?

 - R.
