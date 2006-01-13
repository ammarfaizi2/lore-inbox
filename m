Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161372AbWAMGLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161372AbWAMGLI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 01:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbWAMGLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 01:11:08 -0500
Received: from smtp.osdl.org ([65.172.181.4]:49576 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751505AbWAMGLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 01:11:07 -0500
Date: Thu, 12 Jan 2006 22:10:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: dwmw2@infradead.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       drepper@redhat.com, dhowells@redhat.com
Subject: Re: [PATCH] [5/6] Handle TIF_RESTORE_SIGMASK for i386
Message-Id: <20060112221037.5dbc3dd9.akpm@osdl.org>
In-Reply-To: <20060112205451.392c0c5c.akpm@osdl.org>
References: <1136923488.3435.78.camel@localhost.localdomain>
	<1136924357.3435.107.camel@localhost.localdomain>
	<20060112195950.60188acf.akpm@osdl.org>
	<1137126606.3085.44.camel@localhost.localdomain>
	<20060112205451.392c0c5c.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
>  Note that I have /bin/zsh in /etc/passwd.
>

It's zsh.  I can log in as root (root uses bash) and just type "zsh" and
zsh gets stuck chewing 100% CPU.  strace says:


rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
rt_sigsuspend(~[HUP CHLD RTMIN RT_1])   = -1 EINVAL (Invalid argument)
rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
rt_sigsuspend(~[HUP CHLD RTMIN RT_1])   = -1 EINVAL (Invalid argument)
rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
rt_sigsuspend(~[HUP CHLD RTMIN RT_1])   = -1 EINVAL (Invalid argument)
rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
rt_sigsuspend(~[HUP CHLD RTMIN RT_1])   = -1 EINVAL (Invalid argument)
rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
rt_sigsuspend(~[HUP CHLD RTMIN RT_1])   = -1 EINVAL (Invalid argument)
rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
rt_sigsuspend(~[HUP CHLD RTMIN RT_1])   = -1 EINVAL (Invalid argument)
rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
rt_sigsuspend(~[HUP CHLD RTMIN RT_1])   = -1 EINVAL (Invalid argument)
rt_sigprocmask(SIG_BLOCK, [CHLD], [CHLD], 8) = 0
rt_sigsuspend(~[HUP CHLD RTMIN RT_1])   = -1 EINVAL (Invalid argument)
