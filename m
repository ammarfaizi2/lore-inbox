Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265301AbUAYV5I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 16:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265288AbUAYVz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 16:55:29 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:37848 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265252AbUAYVxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 16:53:46 -0500
Subject: Re: [lkml] pseudo tty / kernel compile question
From: David Woodhouse <dwmw2@infradead.org>
To: Karl Tatgenhorst <ketatgenhorst@comcast.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40120DD0.7090802@comcast.net>
References: <Pine.LNX.4.44.0401131148070.18661-100000@eloth>
	 <20040113113650.A2975@flint.arm.linux.org.uk>
	 <20040113114948.B2975@flint.arm.linux.org.uk>
	 <20040113171544.B7256@flint.arm.linux.org.uk>
	 <20040113172441.C7256@flint.arm.linux.org.uk>
	 <40120DD0.7090802@comcast.net>
Content-Type: text/plain
Message-Id: <1075067623.17157.70.camel@lapdancer.baythorne.internal>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Sun, 25 Jan 2004 21:53:43 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has nothing to do with the patch fixing serial drivers, to which
you seem to have replied. Please don't reply to random messages -- if
you mean to starting a new thread then do so properly.

On Sat, 2004-01-24 at 00:16 -0600, Karl Tatgenhorst wrote:
> when I log in over ssh I get /dev/pts/0 when I type tty. But he says it 
> should be of type /dev/ptsp* I know (suspect strongly) that this is 
> configured in the kernel but not where.

Whether you use the new type of pseudo-ttys /dev/pts/XX or whether you
use the old ones is dependent on your user space programs. You should be
using /dev/pts/XX. If you _are_, then the number of available
pseudo-ttys is indeed part of the kernel configuration. It's
CONFIG_UNIX98_PTY_COUNT.

-- 
dwmw2

