Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422703AbWJXV77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422703AbWJXV77 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 17:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422705AbWJXV77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 17:59:59 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:17613 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1422703AbWJXV76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 17:59:58 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Use extents for recording what swap is allocated.
Date: Tue, 24 Oct 2006 23:58:58 +0200
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <1161576857.3466.9.camel@nigel.suspend2.net> <200610242208.34426.rjw@sisk.pl> <20061024213402.GC5662@elf.ucw.cz>
In-Reply-To: <20061024213402.GC5662@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610242358.59439.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 24 October 2006 23:34, Pavel Machek wrote:
> Hi!
> 
> > > Switch from bitmaps to using extents to record what swap is allocated;
> > > they make more efficient use of memory, particularly where the allocated
> > > storage is small and the swap space is large.
> > 
> > As I said before, I like the overall idea, but I have a bunch of
> > comments.
> 
> Okay, if Rafael likes it... lets take a look.
> 
> First... what is the _worst case_ overhead? AFAICT extents are very
> good at the best case, but tend to suck for the worst case...?

I think we'll usually be close to the best case, as we tend to allocate
large consecutive blocks of swap space.
