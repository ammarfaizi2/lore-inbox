Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266505AbUJLRsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266505AbUJLRsc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 13:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266463AbUJLRsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 13:48:09 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:10699 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S266511AbUJLRpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 13:45:25 -0400
Date: Tue, 12 Oct 2004 19:46:05 +0200
From: Andrea Arcangeli <andrea@cpushare.com>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: secure computing for 2.6.7
Message-ID: <20041012174605.GH17372@dualathlon.random>
References: <20041012155942.GG17372@dualathlon.random> <Pine.LNX.4.44.0410121228230.13693-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0410121228230.13693-100000@chimarrao.boston.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2004 at 12:28:48PM -0400, Rik van Riel wrote:
> Looks like it should work, though really only for the
> purposes of cpushare and nothing else.

in the short term I sure agree, and in my humble opinion this is true
for trusted computing too.

However as said boinc and seti would better start using it too.

And people could start using it for other things too every time they
deal with untrusted data or bytecode. The parsing untrusted data case is
especially easy since it won't even require the seccom-loader (since the
executable is trusted before it starts managing the untrusted data
coming from the network). For example you can parse the jpeg into a
seccomp mode task, that gets the jpeg in input of the pipe and it throws
the uncompressed bitmap in output ready to be written in the
framebuffer. Basically every decompression scheme can run in a task
running in seccomp mode and for most usages the only risk is to see or
listen to garbage, but no exploit once the raw data is pushed into the
hardware as "raw data".
