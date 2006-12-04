Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759847AbWLDFNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759847AbWLDFNO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 00:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759848AbWLDFNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 00:13:14 -0500
Received: from smtp.osdl.org ([65.172.181.25]:20408 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1759831AbWLDFNN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 00:13:13 -0500
Date: Sun, 3 Dec 2006 21:13:07 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Aucoin@Houston.RR.com, "'Tim Schmielau'" <tim@physik3.uni-rostock.de>,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: la la la la ... swappiness
In-Reply-To: <20061203205649.98df030b.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612032111280.3476@woody.osdl.org>
References: <Pine.LNX.4.63.0612032137380.17489@gockel.physik3.uni-rostock.de>
 <200612032356.kB3NuPc0010673@ms-smtp-04.texas.rr.com> <20061203205649.98df030b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 3 Dec 2006, Andrew Morton wrote:

> On Sun, 3 Dec 2006 17:56:30 -0600
> "Aucoin" <Aucoin@Houston.RR.com> wrote:
> 
> > I hope I haven't muddied things up even more but basically what we want to
> > do is find a way to limit the number of cached pages for disk I/O on the OS
> > filesystem, even if it drastically slows down the untar and verify process
> > because the disk I/O we really care about is not on any of the OS
> > partitions.
> 
> Try mounting that fs with `-o sync'.

Wouldn't it be much nicer to just lower the dirty-page limit?

	echo 1 > /proc/sys/vm/dirty_background_ratio
	echo 2 > /proc/sys/vm/dirty_ratio

or something. Which we already discussed in another thread and almost 
already decided we should lower the values for big-mem machines..

Hmm?

		Linus
