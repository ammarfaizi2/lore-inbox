Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbUCUWTz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 17:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbUCUWSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 17:18:13 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:57232 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261366AbUCUWQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 17:16:42 -0500
To: Ulrich Drepper <drepper@redhat.com>
Cc: "Acker, Dave" <dacker@infiniconsys.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH - InfiniBand Access Layer (IBAL)
References: <08628CA53C6CBA4ABAFB9E808A5214CB01EE9AD7@mercury.infiniconsys.com>
	<405C85A0.7010403@redhat.com>
X-Message-Flag: Warning: May contain useful information
X-Priority: 1
X-MSMail-Priority: High
From: Roland Dreier <roland@topspin.com>
Date: 21 Mar 2004 14:16:36 -0800
In-Reply-To: <405C85A0.7010403@redhat.com>
Message-ID: <52fzc13kxn.fsf@topspin.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Common Lisp)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 21 Mar 2004 22:16:36.0787 (UTC) FILETIME=[2D009030:01C40F92]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Ulrich> The only acceptable order in which things can happen is:

    Ulrich> 1. develop API
    Ulrich> 2. propose API to be accepted by "community"/distributions
    Ulrich> 3. change API if necessary, and go back to 2.
    Ulrich> 4. write applications using new API

I don't think this is reasonable, since nothing is settled enough for
this to work.  On the one hand, InfiniBand and other "fibers" (eg RDMA
over ethernet) are quite experimental.  No one is sure of the right
semantics or the best way to use the interconnect.  On the other hand,
there are people who want to use this stuff right now (eg
high-performance computing people building clusters, database cluster
people, etc).

There are users who want to use InfiniBand now, and making them wait
through your whole process above is simply untenable.  You can't
expect a company selling InfiniBand equipment to say, "Sorry, our
software isn't perfect (although it would work for you now).  Come
back in a year or two."

With that in mind, I think the only order things can happen is:

    1. develop API
    2. implement API
    2a.learn from mistakes and go back to 1.
    3. write applications using API
    4. learn from mistakes and go back to 1.

It's certainly unfortunate that so much InfiniBand software has been
developed behind closed doors, but the industry has finally woken up
and come together around the OpenIB idea to develop Linux support
completely in the open.

When does this software make it into distributions?  Obviously that's
up to the distribution.  Certainly a commercial distribution has
customers of its own to listen to, and I would assume that the
decision would be made based on the appropriate combination of
technical merit and customer demand.

 - Roland
