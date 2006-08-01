Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751651AbWHARCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbWHARCc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 13:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbWHARCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 13:02:32 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:7123 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751564AbWHARCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 13:02:31 -0400
Message-ID: <44CF8925.2030706@oracle.com>
Date: Tue, 01 Aug 2006 10:02:29 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: johnpol@2ka.mipt.ru, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC 1/4] kevent: core files.
References: <20060709132446.GB29435@2ka.mipt.ru>	<20060724.231708.01289489.davem@davemloft.net>	<44C91192.4090303@oracle.com> <20060731.180226.131918297.davem@davemloft.net>
In-Reply-To: <20060731.180226.131918297.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I do not think if we do a ring buffer that events should be obtainable
> via a syscall at all.  Rather, I think this system call should be
> purely "sleep until ring is not empty".

Mmm, yeah, of course.  That's much simpler.  I'm looking forward to
Evgeniy's next patch set.

> The ring buffer size, as Evgeniy also tried to describe, is bounded
> purely by the number of registered events.

Yeah.  fwiw, fs/aio.c has this property today.

- z
