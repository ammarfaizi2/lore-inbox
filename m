Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbTKXVJv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 16:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbTKXVJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 16:09:51 -0500
Received: from mail.gmx.de ([213.165.64.20]:25230 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261659AbTKXVJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 16:09:48 -0500
X-Authenticated: #20450766
Date: Mon, 24 Nov 2003 22:08:27 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Bradley Chapman <kakadu_croc@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: What exactly are the issues with 2.6.0-test10 preempt?
In-Reply-To: <20031124191459.99375.qmail@web40902.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0311242202430.2874-100000@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Nov 2003, Bradley Chapman wrote:

> I saw in Linus' 2.6.0-test10 announcement that preempt is suffering from some
> problems and should not be used. However, I am currently running 2.6.0-test10
> with CONFIG_PREEMPT=y and nothing has appeared yet. To see if the problem appeared
> under stress, I started an A/V trailer playback with mplayer and then ran the
> find command on both my home directory and the 2.6.0-test10 kernel source directory,
> with the expected result - mplayer did not skip, neither find invocation broke,
> and there were no nasty errors in dmesg.
>
> So what exactly is the problem?

Well, FWIW, I'm getting 100% reproducible Oopses on __boot__ by enabling
preemption AND (almost) all kernel-hacking CONFIG_DEBUG_* options - see my
post of 21.11.2003 with subject "[OOPS] 2.6.0-test7 + preempt + hacking".
If required, could try to narrow it down to 1 CONFIG option. However, the
Oops itself happens somewhere in NFS code (see backtrace in above email
for details).

Guennadi
---
Guennadi Liakhovetski




