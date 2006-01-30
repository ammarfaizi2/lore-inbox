Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWA3JGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWA3JGU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWA3JGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:06:20 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:61840
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S932148AbWA3JGS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:06:18 -0500
Subject: Re: [patch] fix alarm() return value
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Gerd Hoffmann <kraxel@suse.de>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <43DDD503.3060008@suse.de>
References: <43DDD503.3060008@suse.de>
Content-Type: text/plain
Date: Mon, 30 Jan 2006 10:07:42 +0100
Message-Id: <1138612062.15232.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-30 at 09:57 +0100, Gerd Hoffmann wrote:
>   Hi folks,
> 
> This patch fixes the alarm() system call return value.  The alarm(2)
> syscall is supposed to return the reamining seconds.  The hrtimer
> switchover broke this because the code tries to gather the remaining
> time _after_ canceling the timer.  Trivial fix below.

Thanks. The fix is already in -mm and scheduled to go into 2.6.16

	tglx




