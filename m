Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265944AbTIKBmY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 21:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265927AbTIKBmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 21:42:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:31360 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265944AbTIKBmV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 21:42:21 -0400
Date: Wed, 10 Sep 2003 18:44:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: richard.brunner@amd.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-Id: <20030910184414.7850be57.akpm@osdl.org>
In-Reply-To: <20030911012708.GD3134@wotan.suse.de>
References: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com>
	<20030911012708.GD3134@wotan.suse.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
>  +static int is_prefetch(struct pt_regs *regs, unsigned long addr)

Can we make this code go away if the configured CPU is, say, Intel?
(I couldn't find a sane CONFIG_ setting to use for this).

It might be vaguely interesting to add a user-visible counter for this
event? If someone somehow comes up with an application which hits the fault
frequently they will take a big performance hit.

