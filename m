Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261640AbSLHWuL>; Sun, 8 Dec 2002 17:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbSLHWuL>; Sun, 8 Dec 2002 17:50:11 -0500
Received: from rth.ninka.net ([216.101.162.244]:61155 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S261640AbSLHWuK>;
	Sun, 8 Dec 2002 17:50:10 -0500
Subject: Re: 2.5.50-BK + 24 CPUs
From: "David S. Miller" <davem@redhat.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Manfred Spraul <manfred@colorfullife.com>, anton@samba.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20021208212808.GY9882@holomorphy.com>
References: <3DF3B7FB.9010902@colorfullife.com> 
	<20021208212808.GY9882@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Dec 2002 15:22:58 -0800
Message-Id: <1039389778.13079.1.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-08 at 13:28, William Lee Irwin III wrote:
> Hmm. What happened to that pipe buffer size increase patch? That sounds
> like it might help here, but only if those things are trying to shove
> more than 4KB through the pipe at a time.

You probably mean the zero-copy pipe patches, which I think really
should go in.  The most recent version of the diffs I saw didn't
use the zero copy bits unless the trasnfers were quite large so it
should be ok and not pessimize small transfers.

That patch has been gathering cobwebs for more than a year now when I
first did it, let's push this in already :-)

