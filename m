Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261595AbUK1XUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbUK1XUs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 18:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUK1XUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 18:20:47 -0500
Received: from fw.osdl.org ([65.172.181.6]:37296 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261595AbUK1XUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 18:20:44 -0500
Date: Sun, 28 Nov 2004 15:20:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
cc: akpm@osdl.org, mingo@elte.hu, roland@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] use pid_alive in proc_pid_status
In-Reply-To: <41A9B589.1090005@colorfullife.com>
Message-ID: <Pine.LNX.4.58.0411281519200.22796@ppc970.osdl.org>
References: <41A9B589.1090005@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Nov 2004, Manfred Spraul wrote:
> 
> What do you think? Are you aware of further instances where p->pid is 
> still used to check if a thread is alive?

Looks good, except I hate how you have a function that does a single 
pointer derefence and a test.

There are cases where inline functions bloat up the code, but there are 
cases where a function call is bigger than the function body. This seems 
to be one of them.

		Linus
