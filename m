Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129466AbRCPJfJ>; Fri, 16 Mar 2001 04:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129854AbRCPJet>; Fri, 16 Mar 2001 04:34:49 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:17671 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S129466AbRCPJej>; Fri, 16 Mar 2001 04:34:39 -0500
Message-ID: <3AB1DDF3.990655FA@idb.hist.no>
Date: Fri, 16 Mar 2001 10:33:39 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: Sampsa Ranta <sampsa@netsonic.fi>, linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.2 network performances
In-Reply-To: <Pine.LNX.4.33.0103151540240.856-100000@nalle.netsonic.fi>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sampsa Ranta wrote:

> Yesterday I discovered that the load I can throw out to network seems to
> depend on other activities running on machine. I was able to get
> throughput of 33M/s with ATM when machine was idle, while I compiled
> kernel at same time, the throughput was 135M/s.
> 
> So, I suggest you try to compile kernel while running your UDP stream!

Ouch.  My guess is the kernel looks for stuff to do when scheduling, and
compiling will definitely cause more of that.  Maybe it waits for
the next timer interrupt when idle, instead of checking if there's
more to do?  

Helge Hafting
