Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266258AbUFUOa4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266258AbUFUOa4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 10:30:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266259AbUFUOa4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 10:30:56 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:11975 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266258AbUFUOay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 10:30:54 -0400
Date: Mon, 21 Jun 2004 10:33:01 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Urban Widmark <urban@teststation.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6] Fix smbfs readdir oops
In-Reply-To: <Pine.LNX.4.44.0406211055340.19689-100000@cola.local>
Message-ID: <Pine.LNX.4.58.0406211030340.3273@montezuma.fsmlabs.com>
References: <Pine.LNX.4.44.0406211055340.19689-100000@cola.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jun 2004, Urban Widmark wrote:

> On Sun, 20 Jun 2004, Zwane Mwaikambo wrote:
>
> > This has been reported a couple of times and is consistently causing some
> > folks grief, so Urban, would you mind terribly if i send this patch to at
> > least clear current bug reports. If there is additional stuff you want
> > ontop of this let me know and i can send a follow up patch.
>
> I should read all my mail before replying. Yes, this is a problem for
> people and I was thinking the same thing that we should get this in now
> and fix the remaining problem later.
>
> One question:
> Why do you need conn_complete? Isn't "server->state == CONN_VALID" good
> enough?

I couldn't use CONN_VALID to mark when the connection was completely up
because it's used in some branch decisions during connection setup. So
moving it further down in smb_newconn broke things for the testers.

> And are you still working on fixing the remaining "multiple-ls" problem?
> (The one where one ls would work and the other return an error).
> Or is that fixed in this version?

I'll be working on that, i recall that there is also a bugzilla entry for
it.

Thanks,
	Zwane

