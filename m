Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263904AbTLEHPH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 02:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263909AbTLEHPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 02:15:06 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:24580 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263904AbTLEHPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 02:15:02 -0500
Date: Fri, 5 Dec 2003 07:14:55 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nathan Scott <nathans@sgi.com>
Cc: Linus Torvalds <torvalds@osdl.org>, pinotj@club-internet.fr,
       manfred@colorfullife.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Message-ID: <20031205071455.A19514@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nathan Scott <nathans@sgi.com>, Linus Torvalds <torvalds@osdl.org>,
	pinotj@club-internet.fr, manfred@colorfullife.com, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <mnet1.1070562461.26292.pinotj@club-internet.fr> <Pine.LNX.4.58.0312041035530.6638@home.osdl.org> <Pine.LNX.4.58.0312041050050.6638@home.osdl.org> <20031204212110.GB567@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031204212110.GB567@frodo>; from nathans@sgi.com on Fri, Dec 05, 2003 at 08:21:10AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 08:21:10AM +1100, Nathan Scott wrote:
> Yeah, thats pretty silly stuff - and should be fairly easy to
> fix by using a pagebuf flag to differentiate the two.  Will do.

IMHO a flags is wrong here.  Just maek pb_addr always a pointer and
for the case it's the preallocated array make it point pb_page_array
or something like that.  Then check whether pb_addr is pointing to the
preallocated array.
