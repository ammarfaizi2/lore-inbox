Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbTI3PqX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 11:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261575AbTI3PqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 11:46:20 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:1029 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261598AbTI3Pp5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 11:45:57 -0400
Date: Tue, 30 Sep 2003 11:36:20 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Dave Jones <davej@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon Prefetch workaround for 2.6.0test6
In-Reply-To: <20030930132729.GB23333@redhat.com>
Message-ID: <Pine.LNX.3.96.1030930112002.9817B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Sep 2003, Dave Jones wrote:

> On Mon, Sep 29, 2003 at 09:02:39PM +0000, bill davidsen wrote:
>  > In article <20030929125629.GA1746@averell>, Andi Kleen  <ak@muc.de> wrote:

>  > I have to try this on a P4 and K7, but WRT "Only checks on AMD K7+ CPUs"
>  > I hope you meant "only generates code if AMD CPU is target" and not that
>  > the code size penalty is still there for CPUs which don't need it.
> 
> NO NO NO NO NO.
> This *has* to be there on a P4 kernel too, as we can now boot those on a K7 too.
> The 'code size penalty' you talk about is in the region of a few hundred
> bytes. Much less than a page. There are far more obvious bloat candidates.

Clearly you don't do embedded or small applications, and take the attitude
that people should try to find hundreds of bytes elsewhere to compensate
for the bytes you want to force into the kernel to support a bugfix for
one vendor.

You can build a 386 kernel which will run fine on K7 if you are too
limited in resources to build a proper matching kernel for the target
system. The attitude that there is bloat in the kernel already so we can
just add more as long as it doesn't inconvenience you is totally at odds
with the long tradition of Linux being lean and mean.

Linus wouldn't let dump to disk in the kernel because it wasn't generally
useful, I am amazed that he is letting 300 bytes of vendor bugfix which is
totally without value to any other system go in without ifdef's to limit
the memory penalty to the relevant CPUs.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

