Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285385AbRLGDAs>; Thu, 6 Dec 2001 22:00:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285387AbRLGDAj>; Thu, 6 Dec 2001 22:00:39 -0500
Received: from pizda.ninka.net ([216.101.162.242]:45185 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S285385AbRLGDAW>;
	Thu, 6 Dec 2001 22:00:22 -0500
Date: Thu, 06 Dec 2001 18:59:48 -0800 (PST)
Message-Id: <20011206.185948.55509326.davem@redhat.com>
To: lm@bitmover.com
Cc: alan@lxorguk.ukuu.org.uk, phillips@bonn-fries.net, davidel@xmailserver.org,
        rusty@rustcorp.com.au, Martin.Bligh@us.ibm.com, riel@conectiva.com.br,
        lars.spam@nocrew.org, hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011206184327.B4235@work.bitmover.com>
In-Reply-To: <20011206161744.V27589@work.bitmover.com>
	<20011206.183709.71088955.davem@redhat.com>
	<20011206184327.B4235@work.bitmover.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Larry McVoy <lm@bitmover.com>
   Date: Thu, 6 Dec 2001 18:43:27 -0800
   
   However, where it wins big is on everything else.  Please explain to me how
   you are going to make a scheduler that works for 64 CPUS that doesn't suck?

What stops me from basically doing a scheduler which ends up doing
what ccCluster does, groups of 4 cpu nodes?  Absolutely nothing of
course.  How is ccCluster unique in this regard then?

The scheduler is a mess right now only because Linus hates making
major changes to it.

   We can then go down the path of ... the networking stack ...
   signals ...

Done and done.  Device drivers are mostly done, and what was your
other category... oh process interfaces, those are done too.
   
In fact character devices are the only ugly area in 2.5.x, and
who really cares if TTYs scale to 64 cpus :-)  But this will get
mostly done anyways to kill off the global kernel lock completely.

   There is a hell of a lot of threading that has to go on to get to
   64 cpus and it screws the heck out of the uniprocessor performance.

Not with CONFIG_SMP turned off.  None of the interesting SMP overhead
hits the uniprocessor case.

Why do you keep talking about uniprocessor being screwed?  This is why
we have CONFIG_SMP, to nop the bulk of it out.

   I think you want to prove how studly you are at threading, David,

No, frankly I don't.

What I want is for you to show what is really unique and new about
ccClusters and what incredible doors are openned up by it.  So far I
have been shown ONE, and that is the high availability aspect.

To me, it is far from the holy grail you portray it to be.

   Let's go have some beers and talk about it off line.

How about posting some compelling arguments online first? :-)

It all boils down to the same shit currently.  "ccClusters lets you do
this", and this is leading to "but we can do that already today".

Franks a lot,
David S. Miller
davem@redhat.com
