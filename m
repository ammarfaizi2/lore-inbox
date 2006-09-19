Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWISEzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWISEzV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 00:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbWISEzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 00:55:20 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:63940 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1750789AbWISEzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 00:55:19 -0400
X-Sasl-enc: ZqovtLZIOIliOJ+q3jIxBf1AUY0CKruLwMgJVKhQ0nDw 1158641718
Subject: Re: [PATCH] autofs4 - zero timeout prevents shutdown
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
Cc: autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <20060918213853.d4628ba0.akpm@osdl.org>
References: <Pine.LNX.4.64.0609191126080.11565@raven.themaw.net>
	 <20060918211123.84e583cf.akpm@osdl.org>
	 <1158640433.3003.20.camel@raven.themaw.net>
	 <20060918213853.d4628ba0.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 19 Sep 2006 12:55:10 +0800
Message-Id: <1158641710.3003.29.camel@raven.themaw.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-09-18 at 21:38 -0700, Andrew Morton wrote:
> On Tue, 19 Sep 2006 12:33:52 +0800
> Ian Kent <raven@themaw.net> wrote:
> 
> > On Mon, 2006-09-18 at 21:11 -0700, Andrew Morton wrote:
> > > On Tue, 19 Sep 2006 11:48:15 +0800 (WST)
> > > Ian Kent <raven@themaw.net> wrote:
> > > 
> > > > If the timeout of an autofs mount is set to zero then umounts
> > > > are disabled. This works fine, however the kernel module checks
> > > > the expire timeout and goes no further if it is zero. This is
> > > > not the right thing to do at shutdown as the module is passed
> > > > an option to expire mounts regardless of their timeout setting.
> > > 
> > > Is this a new feature, or a regression since <when>?
> > 
> > It's a regression which I must have introduced a long time ago. I can go
> > back and check the kernels if you'd like more specific info.
> > 
> > It should work this way and a recent report alerted me to it.
> > 
> 
> Well..  I'm trying to work out if it's a 2.6.18 thing or whether we can
> hold it over.

I had a quick look and it appears to be present as far back as 2002/06
in 2.4. I'm a bit puzzled why I haven't seen it before as I'm sure I've
tested this over the years, never the less it looks so clearly wrong to
me know.

It's a bug fix and given it's been around so long, not a widely used.

Personally I'd like to get it into 2.6.18.
As always I'm happy with whatever decision you make.

Ian


