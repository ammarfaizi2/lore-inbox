Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263278AbUJ2A7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263278AbUJ2A7G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263248AbUJ2A6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:58:13 -0400
Received: from smtp3.akamai.com ([63.116.109.25]:23037 "EHLO smtp3.akamai.com")
	by vger.kernel.org with ESMTP id S263255AbUJ2Azx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:55:53 -0400
Message-ID: <41819514.C25D7A51@akamai.com>
Date: Thu, 28 Oct 2004 17:55:48 -0700
From: Prasanna Meda <pmeda@akamai.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, davem@redhat.com
Subject: Re: rcv_wnd = init_cwnd*mss
References: <DB2C167D8FFDEA45B8FC0B1B75E3EE154A3B08@usca1ex-priv1.sanmateo.corp.akamai.com> <20041028165658.753eee50.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:

> On Wed, 27 Oct 2004 23:15:48 -0700
> "Meda, Prasanna" <pmeda@akamai.com> wrote:
>
> > Thanks, still it is unclear to me why are we
> > downsizing the advertised window(rcv_wnd) to cwnd?
> > To defeat disobeying sender, or something like below?
>
> There is never any reason to advertise a receive window
> larger than the initial congestion window of the sender
> could ever be.
>
> Setting it properly like this also makes sure that we do
> receive window update events at just the right place as
> the sender starts sending us the initial data frames.

That makes sense!

But are we coping with cwnd increase on sender?
Looks rcv rwnd s updated by only 1 pkt at time.


Thanks,
Prasanna.

