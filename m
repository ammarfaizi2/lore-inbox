Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270713AbTHJVfh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 17:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270714AbTHJVfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 17:35:37 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:41868 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S270713AbTHJVfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 17:35:30 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Sun, 10 Aug 2003 23:35:26 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: akpm@osdl.org, andrea@suse.de, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-Id: <20030810233526.0f7bf65b.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.44.0308081232430.8384-100000@logos.cnet>
References: <20030808170536.23118033.skraw@ithnet.com>
	<Pine.LNX.4.44.0308081232430.8384-100000@logos.cnet>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Aug 2003 12:33:28 -0300 (BRT)
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:

> > > > Ah yes, and from the long series of tests I can tell that the box won't
> > > > crash with UP kernel. I can re-check that with rc1 if this is useful.
> > > 
> > > Okey. Thats useful information.

During this weekend I did several tests around SMP and UP, and I can definitely
confirm the box does not crash under rc2-UP kernel, but collapses within hours
under rc2-SMP.

> > > How hard would it be for you to try ext3 
> > > as the filesystem (as Andrew suggested) ? 

I spent half the weekend to turn the setup from reiserfs over to ext3
completely preserving the data. The box runs now with rc2-SMP-ext3 (no reiserfs
present any longer). I will send notice if/when it crashes.

>From looking at the tests so far I would say the setup is remarkably slower in
terms of writing to ext3 via nfs and sync option set. I think especially the
"sync" is very visible - unlike reiserfs.

Regards,
Stephan
