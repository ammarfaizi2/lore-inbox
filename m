Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261173AbUKVWmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261173AbUKVWmW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 17:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbUKVWkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 17:40:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:57993 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262434AbUKVWUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:20:30 -0500
Date: Mon, 22 Nov 2004 14:24:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: Add disable_clkrun option
Message-Id: <20041122142439.45d5f439.akpm@osdl.org>
In-Reply-To: <87brdqxjn1.fsf@devron.myhome.or.jp>
References: <87brdqxjn1.fsf@devron.myhome.or.jp>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
> Hi,
> 
> I received report that transmission of Realtek 8139 doesn't work.  The
> cause of this problem was CLKRUN protocols of laptop's TI 12xx CardBus
> bridge.
> 
> And I remember that this problem had happened on Thinkpad before. In
> the case, problem seems solved by similar workaround of sound/oss/cs46xx.c.

What is a CLKRUN protocol and why do we need to disable it?  Is it a
hardware bug, or is the kernel malfunctioning in some way?

> This patch adds "disable_clkrun" option as workaround of problem to
> yenta_socket.

We should add a MODULE_PARM_DESC as well, so users have some hope of finding
this option.

But what are the symptoms of the problem?  How would a user know that he
should try using this option?

