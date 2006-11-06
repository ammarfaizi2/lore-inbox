Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423779AbWKFK0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423779AbWKFK0Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 05:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423782AbWKFK0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 05:26:23 -0500
Received: from mail.gmx.de ([213.165.64.20]:44209 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1423779AbWKFK0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 05:26:23 -0500
X-Authenticated: #14349625
Subject: Re: realtime-preempt patch-2.6.18-rt7 oops
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Rui Nuno Capela <rncbc@rncbc.org>, Daniel Walker <dwalker@mvista.com>,
       linux-kernel@vger.kernel.org, Karsten Wiese <fzu@wemgehoertderstaat.de>
In-Reply-To: <20061106101117.GA20616@elte.hu>
References: <454BC8D1.1020001@rncbc.org> <454BF608.20803@rncbc.org>
	 <454C714B.8030403@rncbc.org> <454E0976.8030303@rncbc.org>
	 <454E15B0.2050008@rncbc.org>
	 <1162742535.2750.23.camel@localhost.localdomain>
	 <454E2FC1.4040700@rncbc.org> <1162797896.6126.5.camel@Homer.simpson.net>
	 <20061106093815.GB14388@elte.hu>
	 <1162807371.13579.4.camel@Homer.simpson.net>
	 <20061106101117.GA20616@elte.hu>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 11:26:35 +0100
Message-Id: <1162808795.23683.2.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-11-06 at 11:11 +0100, Ingo Molnar wrote:
> * Mike Galbraith <efault@gmx.de> wrote:
> 
> > > could you try the patch below, does it help? (a quick review seems 
> > > to suggest that all codepaths protected by kretprobe_lock are 
> > > atomic)
> > 
> > Ah, so I did do the right thing.  Besides the oops, I was getting a 
> > pretty frequent non-deadly...
> 
> yeah ...
> 
> > ...so turned it back into a non-sleeping lock.
> > 
> > You forgot kprobes.h
> 
> so the patch solves this problem for you?

Yeah, seems to.  I'll let it run make check in a loop for a while to
make sure the fatal oops stays gone too though.  If you don't hear from
me, all is peachy (it will be methinks)

	-Mike

