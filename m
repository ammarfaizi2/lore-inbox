Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264370AbTE0W3z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 18:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264383AbTE0W3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 18:29:54 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:55270 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264370AbTE0W3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 18:29:52 -0400
Date: Tue, 27 May 2003 15:40:49 -0700
From: Andrew Morton <akpm@digeo.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: marcelo@conectiva.com.br, m.c.p@wolk-project.de,
       linux-kernel@vger.kernel.org, c-d.hailfinger.kernel.2003@gmx.net,
       manish@storadinc.com, christian.klose@freenet.de, wli@holomorphy.com
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
Message-Id: <20030527154049.22411c59.akpm@digeo.com>
In-Reply-To: <20030527223800.GC1453@dualathlon.random>
References: <3ED2DE86.2070406@storadinc.com>
	<200305271952.34843.m.c.p@wolk-project.de>
	<Pine.LNX.4.55L.0305271457090.756@freak.distro.conectiva>
	<200305272004.02376.m.c.p@wolk-project.de>
	<20030527182547.GG3767@dualathlon.random>
	<Pine.LNX.4.55L.0305271530580.2100@freak.distro.conectiva>
	<20030527200339.GI3767@dualathlon.random>
	<Pine.LNX.4.55L.0305271707370.9487@freak.distro.conectiva>
	<20030527202520.GN3767@dualathlon.random>
	<20030527151830.40b3d281.akpm@digeo.com>
	<20030527223800.GC1453@dualathlon.random>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 May 2003 22:43:07.0028 (UTC) FILETIME=[5758D540:01C324A1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> On Tue, May 27, 2003 at 03:18:30PM -0700, Andrew Morton wrote:
> > Andrea Arcangeli <andrea@suse.de> wrote:
> > >
> > > However the last numbers from Randy showed my tree going faster than 2.5
> > > with bonnie and tiotest so I think we don't need to worry and I would
> > > probably not fix it in a different way in 2.4 even if it would mean a 1%
> > > degradation.
> > 
> > That could be because -aa quadruples the size of the VM readahead window.
> > 
> > Changes such as that should be removed when assessing the performance
> > impact of this particular patch.
> 
> I understand that was a generic benchmark against 2.5, not meant to
> evaluate the effect of the fixed readahead (see the name of the patch
> "readahead-got-broken-somehwere"). I don't see any good reason why
> should Randy cripple down my tree before benchmarking against 2.5? if
> something it's ok to apply some of my patches to 2.5, that's great, the
> other way around not IMHO.
> 

No.

What I am saying is that evaluation of the effect of an IO scheduler change
cannot be performed when there is a 4:1 change in the readhead window present
in the same tree.

ie: we cannot conclude anything about the effect of the IO scheduler change
from Randy's numbers.  Too many variables.


