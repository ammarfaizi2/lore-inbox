Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270432AbTGMW4R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 18:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270433AbTGMW4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 18:56:17 -0400
Received: from pizda.ninka.net ([216.101.162.242]:18118 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S270432AbTGMW4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 18:56:15 -0400
Date: Sun, 13 Jul 2003 16:02:00 -0700
From: "David S. Miller" <davem@redhat.com>
To: Roland Dreier <roland@topspin.com>
Cc: alan@storlinksemi.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: TCP IP Offloading Interface
Message-Id: <20030713160200.571716cf.davem@redhat.com>
In-Reply-To: <52u19qwg53.fsf@topspin.com>
References: <ODEIIOAOPGGCDIKEOPILCEMBCMAA.alan@storlinksemi.com>
	<20030713004818.4f1895be.davem@redhat.com>
	<52u19qwg53.fsf@topspin.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jul 2003 09:22:32 -0700
Roland Dreier <roland@topspin.com> wrote:

>     David> TOE is evil, read this:
> 
>     David> http://www.usenix.org/events/hotos03/tech/full_papers/mogul/mogul.pdf

> Your ideas are certainly very interesting, and I would be happy to see
> hardware that supports flow identification.  But the Usenix paper
> you're citing completely disagrees with you!

I didn't say I agree with all of Moguls ideas, just his anti-TOE
arguments.  For example, I also think RDMA sucks too yet he thinks
it's a good iea.

>  For example, Mogul writes:
> 
>  "Nevertheless, copy-avoidance designs have not been widely adopted,
>   due to significant limitations. For example, when network maximum
>   segment size (MSS) values are smaller than VM page sizes, which is
>   often the case, page-remapping techniques are insufficient (and
>   page-remapping often imposes overheads of its own.)"

On send this doesn't matter, on receive you use my clever receive
buffer handling + flow cache idea to accumulate the data portion of
packets into page sized chunks for the networking to flip.

You obviously don't understand my ideas if you think that it matters
whether there is some relationship between the MTU and the system
page size necessary for the scheme to work.
