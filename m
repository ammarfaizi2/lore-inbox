Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265882AbUATXFz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 18:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265886AbUATXFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 18:05:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:3006 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265882AbUATXFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 18:05:15 -0500
Date: Tue, 20 Jan 2004 15:06:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Subject: Re: swsusp does not stop DMA properly during resume
Message-Id: <20040120150629.6949eda7.akpm@osdl.org>
In-Reply-To: <20040120224653.GA19159@elf.ucw.cz>
References: <20040120224653.GA19159@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
> 
> As Ben pointed out, swsusp is not doing the right thing with devices
> in 2.6.1. I had patch for a long time here, and it needs to go
> in... It stops them before copying pages back, so there are no issues
> with running DMAs etc.

I _think_ what this patch is doing is suspending all devices from within
the boot kernel before starting into the resumed kernel.  Is this correct?

> +	update_screen(fg_console);	/* Hmm, is this the problem? */

Cryptic comment.  To what "problem" does this refer?


