Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265203AbTLROhy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 09:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265204AbTLROhy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 09:37:54 -0500
Received: from web13908.mail.yahoo.com ([216.136.175.71]:36357 "HELO
	web13908.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265203AbTLROhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 09:37:43 -0500
Message-ID: <20031218143741.25747.qmail@web13908.mail.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Thu, 18 Dec 2003 06:37:41 -0800 (PST)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: RAID-0 read perf. decrease after 2.4.20
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0312181140540.4547-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
> 
> 
> On Tue, 16 Dec 2003, Martin Knoblauch wrote:
> 
> > On Monday 08 December 2003 13:47, Marcelo Tosatti wrote:
> > 
> > Hi Marcelo,
> > 
> > > 2.4.20-aa included rmap and some VM modifications most notably
> > > "drop_behind()" logic which I believe should be the reason for
> the
> > huge
> > > read speedups. Can you please try it? Against 2.4.23.
> > 
> >  Just some feedback:
> > 
> > echo 511 > /proc/sys/vm/max-readahead
> > 
> >  brings back the read performance of my 30 disks on 4 controller
> > LVM/RAID0.
> 
> Great.
> 

 Indeed :-) Just to clarify - the modification of max-readahead was
sufficient to "fix" the observed read performance degradation. I did
not apply (or reverse) anything on top of 2.4.22.

 Actually 255 would have been sufficient, 511 proved to be a small bit
better :-))

Martin

=====
------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
