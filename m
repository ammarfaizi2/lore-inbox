Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262843AbUCJVVU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 16:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262705AbUCJVVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 16:21:19 -0500
Received: from mail41-s.fg.online.no ([148.122.161.41]:37117 "EHLO
	mail41-s.fg.online.no") by vger.kernel.org with ESMTP
	id S262843AbUCJVVE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 16:21:04 -0500
To: KyoungSoo Park <kyoungso@cs.princeton.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to detect udp packets drops ?
References: <404E36F1.8000908@newsguy.com> <404F6F52.2000202@cs.princeton.edu>
	<yw1xy8q8xw67.fsf@kth.se> <404F855E.9090009@cs.princeton.edu>
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Wed, 10 Mar 2004 22:20:53 +0100
In-Reply-To: <404F855E.9090009@cs.princeton.edu> (KyoungSoo Park's message
 of "Wed, 10 Mar 2004 16:15:10 -0500")
Message-ID: <yw1xoer4xutm.fsf@kth.se>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KyoungSoo Park <kyoungso@cs.princeton.edu> writes:

> Thank you for your kind response.  But, if I follow your test
> senario, I cannot know which entity drops the packets.  Routers on
> the path also can get congested and may drop the packets.

That is true.

> What I really want is to know is if the "kernel"(whch is supposed to
> receive packets) drops packets.

Do you mean you want to know if the kernel's receive buffer overflows?
That could be possible in theory, but I don't know whether it's
possible with the current Linux kernels.

> Also I don't want to contribute to the congestion by sending test UDP
> packets, because that may worsen the situation.
> Isn't there any way to monitor the packet drops at the end host by
> just looking at the "packet drop counter"?

If the packet reaches the end host the only reason for dropping it
would be a filled receive buffer.  The size of the buffer can be set
using setsockopt().

-- 
Måns Rullgård
mru@kth.se
