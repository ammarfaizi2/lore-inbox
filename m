Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbTETAuN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbTETAuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:50:13 -0400
Received: from holomorphy.com ([66.224.33.161]:42986 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263424AbTETAuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:50:09 -0400
Date: Mon, 19 May 2003 18:02:58 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Dan Kegel <dank@kegel.com>, John Myers <jgmyers@netscape.com>,
       linux-aio@kvack.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Comparing the aio and epoll event frameworks.
Message-ID: <20030520010258.GQ2444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Davide Libenzi <davidel@xmailserver.org>,
	Dan Kegel <dank@kegel.com>, John Myers <jgmyers@netscape.com>,
	linux-aio@kvack.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200305192333.QAA12018@pagarcia.nscp.aoltw.net> <Pine.LNX.4.55.0305191657540.6565@bigblue.dev.mcafeelabs.com> <3EC9807D.3080804@kegel.com> <Pine.LNX.4.55.0305191743230.6565@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55.0305191743230.6565@bigblue.dev.mcafeelabs.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
>>> Adding a single shot feature to epoll takes about 5 lines of code,
>>> comments included :) You know how many reuqests I had ? Zero, nada.

On Mon, 19 May 2003, Dan Kegel wrote:
>> I thought edge triggered epoll *was* single-shot.

On Mon, May 19, 2003 at 05:47:15PM -0700, Davide Libenzi wrote:
> For single shot I mean that once you receive one event, you will not
> receive more events for that fd if you do not rearm it. Suppose you
> receive 1000 bytes of data and you get an event (EPOLLIN). If after 10
> seconds you receive another 1000 bytes, you will receive another event.
> This is not single shot.

I think this would be useful for network daemons that would like to
fairly schedule responses (i.e. not re-arm until a client on a given fd
deserves a turn again). IRC daemons would appear to be a perfect
candidate for such. OTOH you may want to wait until someone is writing
such a beast so "it will be used" instead of "it is potentially useful".


-- wli
