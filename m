Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314052AbSEAVHl>; Wed, 1 May 2002 17:07:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314056AbSEAVHk>; Wed, 1 May 2002 17:07:40 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:41106 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S314052AbSEAVHk>;
	Wed, 1 May 2002 17:07:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
Reply-To: conman@kolivas.net
To: dmarkh@cfl.rr.com
Subject: Re: Combined low latency & performance patches for 2.4.18
Date: Thu, 2 May 2002 07:07:36 +1000
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020429142443.A62481333@pc.kolivas.net> <20020430230105.D5CA01A0AA@pc.kolivas.net> <3CCFA3BD.664EE747@cfl.rr.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020501210737.3C40218A8C@pc.kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark

On Wed, 1 May 2002 18:13, you wrote:
> Con Kolivas wrote:
> > On Tue, 30 Apr 2002 02:51, you wrote:
> > > After applying it, if you ever do a make mrproper oldconfig dep bzImage
> > > it fails to compile sched.c as follows
> > >
> > > If I don't  do an mrproper it compiles ok. Haven't tested yet.
> >
> > Hmm
> > I used a make mrproper && make clean followed by manual configuration
> > without any problems but thanks for your input. I'm not claiming to be a
> > patch or kernel guru. Just offering what worked for me.
> >
> > > It's the O1 sched patch. Not your fault....
> >
> > Thanks thats kinda reassuring :)
> >
> > Con.
>
> I take that back. It's the low-latency patch. You must have said no to
> it in your .config.
> I do not think all these patches play well together with the O(1)

Here is the relevant section from my .config:

# Processor type and features
#
CONFIG_LOLAT=y
# CONFIG_LOLAT_SYSCTL is not set

CONFIG_PREEMPT=y

As you can see, the low latency is enabled. I didn't see any point in 
enabling sysctl so I havent tried that. Perhaps that is it? The other thing 
is, I don't believe it works well with SMP which I am not using. 

Con.
