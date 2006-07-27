Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWG0VcM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWG0VcM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 17:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbWG0VcM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 17:32:12 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:54932 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751161AbWG0VcK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 17:32:10 -0400
Message-ID: <44C930D5.9020704@oracle.com>
Date: Thu, 27 Jul 2006 14:32:05 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
CC: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
References: <20060709132446.GB29435@2ka.mipt.ru> <20060724.231708.01289489.davem@davemloft.net> <44C91192.4090303@oracle.com> <20060727200655.GA4586@2ka.mipt.ru>
In-Reply-To: <20060727200655.GA4586@2ka.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> 	int kevent_getevents(int event_fd, struct ukevent *events,
>> 		int min_events, int max_events,
>> 		struct timeval *timeout);
> 
> I used only one syscall for all operations, above syscall is
> essentially what kevent_user_wait() does.

Essentially, yes, but the differences are important.  It's important to
have a clear syscall interface instead of nesting through multiplexers.
 And we should get the batching/latency inputs right.  (I'm for both
min/max elements and arguably timeouts, but I could understand not
wanting to go *that* far.)

> Hmm, it looks like I'm lost here...

Yeah, it seems my description might not have sunk in :).  We're giving
userspace a way to collect events without performing a system call.

> I especially like idea about world happinness in a week or so :)

A few weeks! :)

- z
