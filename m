Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316106AbSHFVLc>; Tue, 6 Aug 2002 17:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316135AbSHFVLc>; Tue, 6 Aug 2002 17:11:32 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:42484 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316106AbSHFVLb>; Tue, 6 Aug 2002 17:11:31 -0400
Subject: Re: backups/dumps/caches
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Richard Bonomo <bonomo@sal.wisc.edu>, linux-kernel@vger.kernel.org,
       Richard Bonomo <bonomo@maddog.sal.wisc.edu>
In-Reply-To: <Pine.LNX.4.44.0208061533520.14600-100000@waste.org>
References: <Pine.LNX.4.44.0208061533520.14600-100000@waste.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 06 Aug 2002 23:34:15 +0100
Message-Id: <1028673255.18478.205.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-06 at 21:54, Oliver Xymoron wrote:
> > 2. Perhaps, naively, is it possible to shut off
> >   caching temporarily (and without rebooting),
> >   accepting the performance hit, while a dump
> >   is done, and then restart caching afterwards?
> 
> Yep. Switch to single user mode, sync all filesystems, unmount them for
> good measure, dump, then switch back to multiuser mode.

If you are using 2.4.19 then the actual bug dump hits is sorted. Dumping
a live fs still will mean you end up restoring a not 100% consistent
state of one file versus another and of file data for a given file. You
have to weigh that against downtime. In most cases the downtime isnt
worth it for having a few files that are logged in a transient state.


