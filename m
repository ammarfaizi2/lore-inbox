Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVBUE6A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVBUE6A (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Feb 2005 23:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVBUE6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Feb 2005 23:58:00 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:14976 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261860AbVBUE56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Feb 2005 23:57:58 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: -rc3 leaking NOT BIO [Was: Memory leak in 2.6.11-rc1?]
Date: Sun, 20 Feb 2005 23:57:40 -0500
User-Agent: KMail/1.7.92
Cc: Andrew Morton <akpm@osdl.org>, noel@zhtwn.com, torvalds@osdl.org,
       kas@fi.muni.cz, axboe@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050121161959.GO3922@fi.muni.cz> <200502170800.28012.kernel-stuff@comcast.net> <1108690714.20053.1692.camel@dyn318077bld.beaverton.ibm.com>
In-Reply-To: <1108690714.20053.1692.camel@dyn318077bld.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502202357.41263.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 February 2005 08:38 pm, Badari Pulavarty wrote:
> > On Wednesday 16 February 2005 06:52 pm, Andrew Morton wrote:
> > > So it's probably an ndiswrapper bug?
> >
> > Andrew,
> > It looks like it is a kernel bug triggered by NdisWrapper. Without
> > NdisWrapper, and with just 8139too plus some light network activity the
> > size-64 grew from ~ 1100 to 4500 overnight. Is this normal? I will keep
> > it running to see where it goes.

[OT]

Didn't wanted to keep this hanging - It turned out to be a strange ndiswrapper 
bug - It seems that the other OS in question allows the following without a 
leak ;) -
ptr =Allocate(...);
ptr = Allocate(...);
:
repeat this zillion times without ever fearing that 'ptr' will leak..

I sent a fix to ndiswrapper-general mailing list on sourceforge if any one is 
using ndiswrapper and having a similar problem.

Parag
