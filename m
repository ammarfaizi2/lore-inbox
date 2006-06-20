Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030181AbWFTIxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbWFTIxG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965219AbWFTIxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:53:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27039 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965076AbWFTIxE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:53:04 -0400
Date: Tue, 20 Jun 2006 01:52:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: ccb@acm.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] fix spinlock-debug looping
Message-Id: <20060620015259.dab285d5.akpm@osdl.org>
In-Reply-To: <20060620084001.GC7899@elte.hu>
References: <1150142023.3621.22.camel@cbox.memecycle.com>
	<20060617100710.ec05131f.akpm@osdl.org>
	<20060619070229.GA8293@elte.hu>
	<20060619005955.b05840e8.akpm@osdl.org>
	<20060619081252.GA13176@elte.hu>
	<20060619013238.6d19570f.akpm@osdl.org>
	<20060619083518.GA14265@elte.hu>
	<20060619021314.a6ce43f5.akpm@osdl.org>
	<20060619113943.GA18321@elte.hu>
	<20060619125531.4c72b8cc.akpm@osdl.org>
	<20060620084001.GC7899@elte.hu>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 10:40:01 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> i obviously agree that any such crash is a serious problem, but is it 
> caused by the spinlock-debugging code?

Judging from Dave Olson <olson@unixfolk.com>'s report: no.  He's getting
hit by NMI watchdog expiry on write_lock(tree_lock) in a !CONFIG_DEBUG_SPINLOCK
kernel.
