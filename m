Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbUAUVwf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 16:52:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265823AbUAUVwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 16:52:35 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:54915
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264257AbUAUVwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 16:52:33 -0500
Date: Wed, 21 Jan 2004 16:51:53 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
cc: Eduard Roccatello <lilo.please.no.spam@roccatello.it>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.1-mm5] Unable to handle kernel paging request
In-Reply-To: <20040121134339.68fea573.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0401211646170.28288@montezuma.fsmlabs.com>
References: <200401211018.51865.lilo.please.no.spam@roccatello.it>
 <20040121134339.68fea573.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jan 2004, Andrew Morton wrote:

> Eduard Roccatello <lilo.please.no.spam@roccatello.it> wrote:
> >
> > 2.6.1-mm5 gives me  "Unable to handle kernel paging request" on load and
> > then it hangs up.
>
> If you disable ipv6 in kernel config, does it boot up OK?

There is an oops in that area (round about the first rebalance tick) with
the scheduler groups code. Only happens on some Uniprocessor boxes, so it
could be a race. Essentially the sched_groups circular list isn't
terminated properly. I'll dig deeper in a bit.
