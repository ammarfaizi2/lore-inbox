Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129715AbRBFSC1>; Tue, 6 Feb 2001 13:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129763AbRBFSCR>; Tue, 6 Feb 2001 13:02:17 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:3413 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129715AbRBFSCC>; Tue, 6 Feb 2001 13:02:02 -0500
Date: Tue, 6 Feb 2001 13:00:48 -0500 (EST)
From: Ben LaHaise <bcrl@redhat.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Anders Eriksson <aer-list@mailandnews.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: sync & asyck i/o
In-Reply-To: <20010206173437.A19836@redhat.com>
Message-ID: <Pine.LNX.4.30.0102061258340.15204-100000@today.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2001, Stephen C. Tweedie wrote:

> It's worth noting that it *is* defined unambiguously in the standards:
> fsync waits until all the data is hard on disk.  Linux will obey that
> if it possibly can: only in cases where the hardware is actively lying
> about when the data has hit disk will the guarantee break down.

It is defined for writes that have begun before the fsync() started.
fsync has no bearing on aio writes until the async writes have completed.
If people are worried about the interaction between an fsync in their app
and an async write, they should be using syncronous writes (which are
perfectly usable with async io).

		-ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
