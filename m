Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265026AbTFCOYY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 10:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbTFCOYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 10:24:24 -0400
Received: from tomts16-srv.bellnexxia.net ([209.226.175.4]:5505 "EHLO
	tomts16-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S265026AbTFCOYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 10:24:23 -0400
Date: Tue, 3 Jun 2003 10:37:46 -0400
From: Marc Heckmann <mh@nadir.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc6: softraid anamoly
Message-ID: <20030603143745.GC3084@nadir.org>
References: <20030603031421.GC1766@nadir.org> <20030603062500.GA10876@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030603062500.GA10876@alpha.home.local>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03, 2003 at 08:25:00AM +0200, Willy Tarreau wrote:
> On Mon, Jun 02, 2003 at 11:14:24PM -0400, Marc Heckmann wrote:
> > I just installed a vanilla 2.4.21-rc6 smp kernel on a redhat 9 system
> > today. To my surprise, the priority of the raid kernel threads are quite
> > odd:
>  
> >     9 root     18446744073709551615 -20     0   1 mdrecoveryd
> >    18 root     18446744073709551615 -20     0   0 raid1d
> >    19 root     18446744073709551615 -20     0   0 raid1d
> >    20 root     18446744073709551615 -20     0   0 raid1d
> >    21 root     18446744073709551615 -20     0   0 raid1d
> 
> Known problem in procps-2.0.11 (sprintf %llu). You should upgrade to 2.0.12 or
> 2.0.13, and you'll see -1 here !

ok. thanks for the info. sorry for the false alarm. I had done some
searching before hand to see if it was something obvious like that
but couldn't find anything. 

Cheers,

-m

