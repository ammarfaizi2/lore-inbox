Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318295AbSHUOdx>; Wed, 21 Aug 2002 10:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318297AbSHUOdx>; Wed, 21 Aug 2002 10:33:53 -0400
Received: from fwext.dif.dk ([130.227.136.2]:19184 "EHLO DIFPST1A.dif.dk")
	by vger.kernel.org with ESMTP id <S318295AbSHUOdw>;
	Wed, 21 Aug 2002 10:33:52 -0400
Subject: RE: Problem determining number of CPUs
From: Jesper Juhl <jju@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: nagyt@otpbank.hu, Matt_Domsch@Dell.com
In-Reply-To: <20BF5713E14D5B48AA289F72BD372D6821CBA0@AUSXMPC122.aus.amer.dell.com>
References: <20BF5713E14D5B48AA289F72BD372D6821CBA0@AUSXMPC122.aus.amer.dell.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 21 Aug 2002 16:37:14 +0200
Message-Id: <1029940635.7255.185.camel@jju_lnx.backbone.dif.dk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-21 at 16:20, Matt_Domsch@Dell.com wrote:
> > Linux kernel versions 2.4.18, 2.4.19, 2.4.20pre4 do not determine
> > correctly the number of CPUs on our system. We see 8 CPUs 
> > instead of 4,
> > however the system works.
> > 
> > Our machine: Dell PowerEdge 6600, 4 Xeon 1400 Mhz, 4GB RAM
> 
> Yes, this is expected behavior due to hyperthreaded processors.
> http://lists.us.dell.com/pipermail/linux-poweredge/2002-July/003465.html
> 

I'm aware that hyperthreading makes each CPU appear as two. But wouldn't
it be possible to determine this fact and report it to the user to avoid
confusion (not everyone knows about hyperthreading) ?

In the case of 4 HT capable CPU's it could be reported like 

8 CPUs (4 physical) 

or something like that to indicate that there is nothing wrong and the
kernel is simply taking advantage of hyperthreading.

Just my two euro-cents...


/Jesper Juhl


