Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285382AbRLGCn4>; Thu, 6 Dec 2001 21:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285383AbRLGCnq>; Thu, 6 Dec 2001 21:43:46 -0500
Received: from bitmover.com ([192.132.92.2]:8072 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S285382AbRLGCn2>;
	Thu, 6 Dec 2001 21:43:28 -0500
Date: Thu, 6 Dec 2001 18:43:27 -0800
From: Larry McVoy <lm@bitmover.com>
To: "David S. Miller" <davem@redhat.com>
Cc: lm@bitmover.com, alan@lxorguk.ukuu.org.uk, phillips@bonn-fries.net,
        davidel@xmailserver.org, rusty@rustcorp.com.au,
        Martin.Bligh@us.ibm.com, riel@conectiva.com.br, lars.spam@nocrew.org,
        hps@intermeta.de, linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
Message-ID: <20011206184327.B4235@work.bitmover.com>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>, lm@bitmover.com,
	alan@lxorguk.ukuu.org.uk, phillips@bonn-fries.net,
	davidel@xmailserver.org, rusty@rustcorp.com.au,
	Martin.Bligh@us.ibm.com, riel@conectiva.com.br,
	lars.spam@nocrew.org, hps@intermeta.de,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011206153257.T27589@work.bitmover.com> <20011206.154735.71088809.davem@redhat.com> <20011206161744.V27589@work.bitmover.com> <20011206.183709.71088955.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011206.183709.71088955.davem@redhat.com>; from davem@redhat.com on Thu, Dec 06, 2001 at 06:37:09PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I still think ccClusters don't solve any new problems in the
> locking space.  "I get rid of it by putting people on different
> filesystems" is not an answer which is unique to ccClusters, current
> systems can do that.

If your point is that it doesn't solve any locking problems in the filesystem,
I'll almost grant you that.  Not quite because ccClusters open the door to 
different ways of solving problems that a traditional SMP doesn't.

However, where it wins big is on everything else.  Please explain to me how
you are going to make a scheduler that works for 64 CPUS that doesn't suck?
And explain to me how that will perform as well as N different scheduler
queues which I get for free.  Just as an example.  We can then go down the
path of every device driver, the networking stack, the process interfaces,
signals, etc.  

There is a hell of a lot of threading that has to go on to get to
64 cpus and it screws the heck out of the uniprocessor performance.
I think you want to prove how studly you are at threading, David,
but what you are really doing is proving that you are buried in the
trees and can't see the forest.  Pop up 50,000 feet and think about it.
Let's go have some beers and talk about it off line.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
