Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbUALXTo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 18:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263441AbUALXTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 18:19:44 -0500
Received: from mail.gmx.de ([213.165.64.20]:37843 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263330AbUALXTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 18:19:37 -0500
X-Authenticated: #20450766
Date: Tue, 13 Jan 2004 00:18:49 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Pavel Machek <pavel@ucw.cz>
cc: Mike Fedyk <mfedyk@matchmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0 NFS-server low to 0 performance
In-Reply-To: <20040108214240.GD467@openzaurus.ucw.cz>
Message-ID: <Pine.LNX.4.44.0401130012100.12912-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Jan 2004, Pavel Machek wrote:

> I've seen slow machine (386sx with ne1000) that could not receive 7 full-sized packets
> back-to-back. You are sending 22 full packets back-to-back.
> I'd expect some of them to be (almost deterministicaly) lost,
> and no progress ever made.

As you, probably, have already seen from further emails on this thread, we
did find out that packets were indeed lost due to various performance
reasons. And the best solution does seem to be switching to TCP-NFS, and
making it the default choice for mount (where available) seems to be a
very good idea.

Thanks for replying anyway.

> In same scenario, TCP detects "congestion" and works mostly okay.

Hm, as long as we are already on this - can you give me a hint / pointer
how does TCP _detect_ a congestion? Does it adjust packet sizes, some
other parameters? Just for the curiousity sake.

Thanks
Guennadi
---
Guennadi Liakhovetski


