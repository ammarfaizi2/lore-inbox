Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261356AbTAQV2p>; Fri, 17 Jan 2003 16:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbTAQV2p>; Fri, 17 Jan 2003 16:28:45 -0500
Received: from packet.digeo.com ([12.110.80.53]:27644 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261356AbTAQV2o>;
	Fri, 17 Jan 2003 16:28:44 -0500
Date: Fri, 17 Jan 2003 13:37:18 -0800
From: Andrew Morton <akpm@digeo.com>
To: Cliff White <cliffw@osdl.org>
Cc: cliffw@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [OSDL][BENCHMARK] Database results 2.4 versus 2.5
Message-Id: <20030117133718.36df6e42.akpm@digeo.com>
In-Reply-To: <200301172123.h0HLNBd19275@mail.osdl.org>
References: <20030117130046.0f73d6d6.akpm@digeo.com>
	<200301172123.h0HLNBd19275@mail.osdl.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jan 2003 21:37:37.0023 (UTC) FILETIME=[A72E28F0:01C2BE70]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cliff White <cliffw@osdl.org> wrote:
>
> > So it sounds like DBT2 is stabilised now, and producing repeatable results? 
> > That's excellent.
> Thanks. the kit's available off Sourceforge now, and we'll have STP version 
> up Mondayish. 

OK.  My utter database ignorance was an
insurmountable-within-two-hour-attention-span problem when I tried to set up
dbt1.

> > So either the I/O scheduler is doing a better job, or the VM page
> > replacement decisions are agreeable for this load.
> 
> Okay. Is there something we could do that would point at one or the other?

Different combinations of working set and physical memory will tell us.

Also, when we have a lot of vmstat/etc traces available we can decide how I/O
bound it is, and whether we need to look at upping the request queue sizes. 
Which is something which we can now do, and which could easily make a
difference here.

But we'll have to get you onto at least 2.5.58 for that ;)

> would a smaller memory database (say 2GB instead of 4GB ) really show you
> anything interesting on a 4GB system, since there's so little pressure? 

Yes, that would be interesting.  We're dealing with single points in
twenty-seven-dimensional space.  Tweaking input parameter individually helps
one gain an understanding of what is going on.
