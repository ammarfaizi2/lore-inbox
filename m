Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319798AbSIMV5B>; Fri, 13 Sep 2002 17:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319800AbSIMV5B>; Fri, 13 Sep 2002 17:57:01 -0400
Received: from puerco.nm.org ([129.121.1.22]:53512 "HELO puerco.nm.org")
	by vger.kernel.org with SMTP id <S319798AbSIMV5A>;
	Fri, 13 Sep 2002 17:57:00 -0400
Date: Fri, 13 Sep 2002 15:59:15 -0600 (MDT)
From: todd-lkml@osogrande.com
X-X-Sender: todd@gp
Reply-To: linux-kernel@vger.kernel.org
To: "David S. Miller" <davem@redhat.com>
cc: "hadi@cyberus.ca" <hadi@cyberus.ca>,
       "tcw@tempest.prismnet.com" <tcw@tempest.prismnet.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "netdev@oss.sgi.com" <netdev@oss.sgi.com>,
       patricia gilfeather <pfeather@cs.unm.edu>
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
In-Reply-To: <20020912.161225.20790415.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0209131553510.10203-100000@gp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dave, all,

On Thu, 12 Sep 2002, David S. Miller wrote:

> I disagree, at least for bulk receivers.  We have no way currently to
> get rid of the data copy.  We desperately need sys_receivefile() and
> appropriate ops all the way into the networking, then the necessary
> driver level support to handle the cards that can do this.

not sure i understand what you're proposing, but while we're at it, why
not also make the api for apps to allocate a buffer in userland that (for
nics that support it) the nic can dma directly into?  it seems likely
notification that the buffer was used would have to travel through the
kernel, but it would be nice to save the interrupts altogether.

this may be exactly what you were saying.

> 
> Once 10gbit cards start hitting the shelves this will convert from a
> nice perf improvement into a must have.

totally agreed.  this is a must for high-performance computing now (since 
who wants to waste 80-100% of their CPU just running the network)?

t.

-- 
todd underwood, vp & cto
oso grande technologies, inc.
todd@osogrande.com

"Those who give up essential liberties for temporary safety deserve
neither liberty nor safety." - Benjamin Franklin

