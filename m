Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTGKPEI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 11:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263199AbTGKPEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 11:04:08 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:58814 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S262984AbTGKPDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 11:03:43 -0400
Date: Fri, 11 Jul 2003 12:15:59 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Chris Mason <mason@suse.com>, ia6432@inbox.ru, green@namesys.com,
       linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
In-Reply-To: <20030711153840.427909e2.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.55L.0307111215380.29472@freak.distro.conectiva>
References: <E19ae9K-000Nas-00.ia6432-inbox-ru@f7.mail.ru>
 <20030710191254.093354d2.skraw@ithnet.com> <Pine.LNX.4.55L.0307101458490.25229@freak.distro.conectiva>
 <1057929320.13317.26.camel@tiny.suse.com> <20030711153840.427909e2.skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 11 Jul 2003, Stephan von Krawczynski wrote:

> On 11 Jul 2003 09:15:21 -0400
> Chris Mason <mason@suse.com> wrote:
>
> > > Andrea, Chris, any idea of why this is happening?
> >
> > My first guess is that blk_oversized_queue is false but there aren't any
> > requests left.  That will pretty much spin in __get_request_wait with
> > irqs off, which sounds similar to what he's hitting.
> >
> > I think we need this hunk even if it doesn't fix his problem.
>
> Strike!
> Your patch solves my problem. I applied it on 2.4.22-pre4 and it now works just
> like -pre2 did.
> Great Chris, compared to the pretty minimal input I could give ...

The fix is already in my BK tree.

Thanks a lot Chris and Stephan.
