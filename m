Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264705AbSKDPbB>; Mon, 4 Nov 2002 10:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264712AbSKDPbB>; Mon, 4 Nov 2002 10:31:01 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:2440 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264705AbSKDPbA>; Mon, 4 Nov 2002 10:31:00 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 4 Nov 2002 07:47:22 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, <hch@lst.de>,
       Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: interrupt checks for spinlocks
In-Reply-To: <Pine.LNX.4.33L2.0211032117190.10796-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0211040746250.1745-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002, Randy.Dunlap wrote:

> | It's not realy a graph Bill.  Each task has a list of acquired locks (
> | by address ). You keep __LINE__ and __FILE__ with you list items. When
> | there's a deadlock you'll have somewhere :
> |
> |    TSK#N	TSK#M
> |    -------------
> |    ...		...
> |    LCK#I	LCK#J
> |    ...		...
> | -> LCK#J	LCK#I
> |
> | Then with a SysReq key you dump the list of acquired locks for each task
> | who's spinning for a lock. IMO it might be usefull ...
>
> What's a task in this context?  Are we (you) talking about
> kernel threads/drivers etc. or userspace?

Hi Randy,

a task here is anything you can identify with a task_struct*



- Davide


