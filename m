Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbVIZVQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbVIZVQe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 17:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932093AbVIZVQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 17:16:34 -0400
Received: from host27-37.discord.birch.net ([65.16.27.37]:18392 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S932089AbVIZVQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 17:16:34 -0400
From: "Roger Heflin" <rheflin@atipa.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: "'Al Boldi'" <a1426z@gawab.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Resource limits
Date: Mon, 26 Sep 2005 16:21:50 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcXCuQR9PhB3L03GTDC5aLQ2u+raLQAAgZoQ
In-Reply-To: <1127754691.27757.26.camel@localhost.localdomain>
Message-ID: <EXCHG2003VnkB4ltFlm00000b18@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 26 Sep 2005 21:12:37.0178 (UTC) FILETIME=[054439A0:01C5C2DF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> On Llu, 2005-09-26 at 09:44 -0500, Roger Heflin wrote:
> > While talking about limits, one of my customers report that if they 
> > set "ulimit -d" to be say 8GB, and then a program goes and
> 
> The kernel doesn't yet support rlimit64() - glibc does but it 
> emulates it best effort. Thats a good intro project for someone
> 
> > It would seem that the best thing to do would be to abort 
> on allocates 
> > that will by themselves exceed the limit.
> 
> 2.6 supports "no overcommit" modes.
> 
> Alan
> 

Ah.

So any limit over 4GB, is emulated through glibc which means the
fix would need to be in the emulation that is outside of the
kernel.

And I think they were setting the limit to more like 32 or 48GB,
and having single allocation's go over that.   Some of the machines
in question have 32GB of ram, others have 64GB of ram, both with
fair amounts of swap, and when the event happens they need to create
enough swap to get enough swap to process the request.

The overcommit thing may do what they want.

                              Thanks.
                              Roger

