Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269963AbTGKNhw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 09:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269964AbTGKNhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 09:37:52 -0400
Received: from 69-55-72-150.ppp.netsville.net ([69.55.72.150]:38855 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id S269963AbTGKNhu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 09:37:50 -0400
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
From: Chris Mason <mason@suse.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: marcelo@conectiva.com.br, ia6432@inbox.ru, green@namesys.com,
       linux-kernel@vger.kernel.org, andrea@suse.de
In-Reply-To: <20030711153840.427909e2.skraw@ithnet.com>
References: <E19ae9K-000Nas-00.ia6432-inbox-ru@f7.mail.ru>
	 <20030710191254.093354d2.skraw@ithnet.com>
	 <Pine.LNX.4.55L.0307101458490.25229@freak.distro.conectiva>
	 <1057929320.13317.26.camel@tiny.suse.com>
	 <20030711153840.427909e2.skraw@ithnet.com>
Content-Type: text/plain
Organization: 
Message-Id: <1057931467.13318.41.camel@tiny.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 11 Jul 2003 09:51:07 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-11 at 09:38, Stephan von Krawczynski wrote:
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

Thanks for the quick test, you've been hugely helpful.

-chris


