Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266250AbTAZAuH>; Sat, 25 Jan 2003 19:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266379AbTAZAuH>; Sat, 25 Jan 2003 19:50:07 -0500
Received: from packet.digeo.com ([12.110.80.53]:59647 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266250AbTAZAuG>;
	Sat, 25 Jan 2003 19:50:06 -0500
Date: Sat, 25 Jan 2003 16:59:53 -0800
From: Andrew Morton <akpm@digeo.com>
To: Tom Sightler <ttsig@tuxyturvy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.59-mm5 hangs on boot
Message-Id: <20030125165953.44e1b655.akpm@digeo.com>
In-Reply-To: <1043542198.3019.4.camel@iso-2146-l1.zeusinc.com>
References: <1043534331.1672.71.camel@iso-2146-l1.zeusinc.com>
	<20030125153217.6ff6e275.akpm@digeo.com>
	<1043542198.3019.4.camel@iso-2146-l1.zeusinc.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Jan 2003 00:59:15.0701 (UTC) FILETIME=[25DBEA50:01C2C4D6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Sightler <ttsig@tuxyturvy.com> wrote:
>
> On Sat, 2003-01-25 at 18:32, Andrew Morton wrote:
> > First up, please see if changing this:
> > 
> > 	static int antic_expire = HZ / 25;
> > 
> > to
> > 
> > 	static int antic_expire = 0;
> > 
> > in drivers/block/deadline-iosched.c fixes it up.
> 
> This worked, but this is obviously not a real fix right?  Just to show
> that that's where the problem is I guess.

Yup, thanks.  I think others have seen a similar problem without the
anticipatory scheduling patch, so there may be a couple of problems here, or
a strange interaction.

> I'll gladly test other patches.

OK, thanks.  Not sure what to suggest at present.  Maybe when Luuk has done
the patch iteration and we've fixed whatever is causing his boot failure we
can then move on.

Are you using RAID at all?
