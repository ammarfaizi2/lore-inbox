Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263201AbTESWpo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 18:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263171AbTESWpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 18:45:44 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:10750 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263201AbTESWpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 18:45:40 -0400
Date: Mon, 19 May 2003 15:54:55 -0700
From: Andrew Morton <akpm@digeo.com>
To: jgmyers@netscape.com (John Myers)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: aio_poll in 2.6
Message-Id: <20030519155455.7fb9788d.akpm@digeo.com>
In-Reply-To: <3EC94DB6.8000405@netscape.com>
References: <fa.mc7vl0v.u7u2ah@ifi.uio.no>
	<200305170054.RAA10802@pagarcia.nscp.aoltw.net>
	<20030516195025.4bf5dd8d.akpm@digeo.com>
	<200305191938.MAA11946@pagarcia.nscp.aoltw.net>
	<1053373716.29227.27.camel@dhcp22.swansea.linux.org.uk>
	<20030519141654.31901ee3.akpm@digeo.com>
	<3EC94DB6.8000405@netscape.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 May 2003 22:58:33.0128 (UTC) FILETIME=[2C0A7A80:01C31E5A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jgmyers@netscape.com (John Myers) wrote:
>
> Andrew Morton wrote:
> 
> >I can do that, but would need the test app...
> >  
> >
> Unfortunately, the thread pool framework the test app uses is proprietary.
> 

That is a problem.

Generally, adding new code in codepaths which lots of apps use is low-risk
because problems will be found quickly.

But from a stabilising-the-kernel viewpoint, adding new code which does not
require elevated privileges, and which is not used by any current
applications and which doesn't even have a decent test suite is a big
worry.

There is a little testcase in
http://www.kvack.org/~bcrl/aio/aio-userspace-18a.tar.gz but it is singly
threaded.

