Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261799AbTK1B3u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 20:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbTK1B3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 20:29:49 -0500
Received: from zero.aec.at ([193.170.194.10]:33033 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261799AbTK1B3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 20:29:48 -0500
To: Joe Korty <joe.korty@ccur.com>
Cc: shemminger@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] possible erronous use of tick_usec in do_gettimeofday
From: Andi Kleen <ak@muc.de>
Date: Fri, 28 Nov 2003 02:29:30 +0100
In-Reply-To: <VOyG.w9.35@gated-at.bofh.it> (Joe Korty's message of "Tue, 25
 Nov 2003 17:50:47 +0100")
Message-ID: <m3oeuxwa9x.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <Lq47.3Go.11@gated-at.bofh.it> <LqGL.4zF.11@gated-at.bofh.it>
	<LAPN.1dU.11@gated-at.bofh.it> <LGLz.1h2.5@gated-at.bofh.it>
	<LVAR.4Mb.3@gated-at.bofh.it> <M4uv.bw.5@gated-at.bofh.it>
	<M7sx.4et.13@gated-at.bofh.it> <MsGE.8cN.19@gated-at.bofh.it>
	<MsZZ.c3.5@gated-at.bofh.it> <Mufp.1YL.15@gated-at.bofh.it>
	<VOyG.w9.35@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty <joe.korty@ccur.com> writes:

> test10's version of do_gettimeofday is using tick_usec which is
> defined in terms of USER_HZ not HZ.
>
> Against 2.6.0-test10-bk1.  Compiled, not tested, for comment only.
>

I added the changes to x86-64, but at least ping still complains 
that the time is going backwards. The machine is running ntpd
and has a high drift (AMD 8111 chipset, doesn't have the most stable
timer in the world)

-Andi
