Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275116AbTHMOxk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 10:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275211AbTHMOxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 10:53:40 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:40838 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S275116AbTHMOxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 10:53:32 -0400
Date: Wed, 13 Aug 2003 11:53:09 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@localhost.localdomain
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: akpm@osdl.org, <andrea@suse.de>, <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>, <mason@suse.com>, <green@namesys.com>
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
In-Reply-To: <20030813125509.360c58fb.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.44.0308131143570.4279-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 13 Aug 2003, Stephan von Krawczynski wrote:

> On Fri, 8 Aug 2003 12:33:28 -0300 (BRT)
> Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
> 
> > That will provide further information yes. We can then know if the problem 
> > is reiserfs specific or not, which is VERY useful.
> > 
> > Again, thanks for your efforts helping us track down the problem.
> 
> Status update:
> 
> uptime:
>  12:45pm  up 2 days 19:39,  18 users,  load average: 2.02, 2.05, 2.06
> 
> Running SMP. So far no crash happened under ext3. 
> Still I see the tar-verification errors. None on the first day, 2 on the second
> and 2 today so far.
> I see a growing possibility that the formerly crashes are directly linked to a
> reiserfs problem, maybe broken SMP-locking.
> If it survives until sunday I will revert all ext3 back to reiserfs to be sure
> it still crashes, then ideas for patches will be welcome :-)

Great you tracked it down. Your previous traces almost always involved
reiserfs calls, which is another indicator that reiserfs is probably the
problem here.

Chris, Oleg, it might be nice if you guys could look at previous oops
reports by Stephan. 

