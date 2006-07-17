Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751593AbWGQAyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbWGQAyY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 20:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWGQAyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 20:54:24 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:4266 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751407AbWGQAyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 20:54:23 -0400
Subject: Re: RFC: cleaning up the in-kernel headers
From: Steven Rostedt <rostedt@goodmis.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>, torvalds@osdl.org, akpm@osdl.org
In-Reply-To: <Pine.LNX.4.64.0607142152420.9010@schroedinger.engr.sgi.com>
References: <20060711160639.GY13938@stusta.de>
	 <Pine.LNX.4.64.0607131201050.28976@schroedinger.engr.sgi.com>
	 <1152937109.27135.101.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607142152420.9010@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Sun, 16 Jul 2006 20:53:50 -0400
Message-Id: <1153097630.17406.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-14 at 21:59 -0700, Christoph Lameter wrote:

> > Now for the vmstat.h, I just tried removing that, and it seems that this
> > is a candidate to be removed from mm.h since mm.h compiles fine without
> > it. But vmstat.h doesn't compile without mm.h.  So it seems that we
> > should add mm.h to vmstat.h, remove vmstat.h from mm.h and for those .c
> > files that break, just add vmstat.h to them.
> 
> Great if you can detangle that.

Are you supporting the effort if I send in patches that removes the
vmstat.h and then goes and tries to find all the places that fail to
compile because of the removal and adds vmstat.h directly, that the
patches would get accepted?

It would probably need to go into -mm for a bit just to find those
places I missed.

This wouldn't be a problem to do and can be accomplished rather quickly,
but I wont waste any time on it if it is doomed at the start.

-- Steve


