Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285041AbRLFICg>; Thu, 6 Dec 2001 03:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285050AbRLFIC0>; Thu, 6 Dec 2001 03:02:26 -0500
Received: from bitmover.com ([192.132.92.2]:8072 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S285041AbRLFICV>;
	Thu, 6 Dec 2001 03:02:21 -0500
Date: Thu, 6 Dec 2001 00:02:16 -0800
From: Larry McVoy <lm@bitmover.com>
To: "David S. Miller" <davem@redhat.com>
Cc: davidel@xmailserver.org, rusty@rustcorp.com.au, lm@bitmover.com,
        Martin.Bligh@us.ibm.com, riel@conectiva.com.br, lars.spam@nocrew.org,
        alan@lxorguk.ukuu.org.uk, hps@intermeta.de,
        linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
Message-ID: <20011206000216.B18034@work.bitmover.com>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	davidel@xmailserver.org, rusty@rustcorp.com.au, lm@bitmover.com,
	Martin.Bligh@us.ibm.com, riel@conectiva.com.br,
	lars.spam@nocrew.org, alan@lxorguk.ukuu.org.uk, hps@intermeta.de,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011206135224.12c4b123.rusty@rustcorp.com.au> <Pine.LNX.4.40.0112051915440.1644-100000@blue1.dev.mcafeelabs.com> <20011205.235617.23011309.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011205.235617.23011309.davem@redhat.com>; from davem@redhat.com on Wed, Dec 05, 2001 at 11:56:17PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 11:56:17PM -0800, David S. Miller wrote:
> These lockless algorithms, instructions like CAS, DCAS, "infinite
> consensus number", it's all crap.  You have to seperate out the access
> areas amongst different cpus so they don't collide, and none of these
> mechanisms do that.

Err, Dave, that's *exactly* the point of the ccCluster stuff.  You get
all that seperation for every data structure for free.  Think about
it a bit.  Aren't you going to feel a little bit stupid if you do all
this work, one object at a time, and someone can come along and do the
whole OS in one swoop?  Yeah, I'm spouting crap, it isn't that easy,
but it is much easier than the route you are taking.  
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
