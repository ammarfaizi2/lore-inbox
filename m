Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945924AbWGOWmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945924AbWGOWmI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 18:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWGOWmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 18:42:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64927 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964801AbWGOWmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 18:42:07 -0400
Date: Sat, 15 Jul 2006 15:42:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tilman Schmidt <tilman@imap.cc>
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: 2.6.18-rc1-mm2: process `showconsole' used the removed sysctl
 system call
Message-Id: <20060715154200.e9138a6b.akpm@osdl.org>
In-Reply-To: <44B8FE64.6040700@imap.cc>
References: <44B8FE64.6040700@imap.cc>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jul 2006 16:40:36 +0200
Tilman Schmidt <tilman@imap.cc> wrote:

> After installing a 2.6.18-rc1-mm2 kernel without sysctl syscall support
> on a standard SuSE 10.0 system, I find the following in my dmesg:
> 
> > [   36.955720] warning: process `showconsole' used the removed sysctl system call
> > [   39.656410] warning: process `showconsole' used the removed sysctl system call
> > [   43.304401] warning: process `showconsole' used the removed sysctl system call
> > [   45.717220] warning: process `ls' used the removed sysctl system call
> > [   45.789845] warning: process `touch' used the removed sysctl system call
> 
> which at face value seems to contradict the statement in the help text
> for the CONFIG_SYSCTL_SYSCALL option that "Nothing has been using the
> binary sysctl interface for some time time now". (sic)
> 
> Meanwhile, the second part of that sentence that "nothing should break"
> by disabling it seems to hold true anyway. The system runs fine, and
> activating CONFIG_SYSCTL_SYSCALL in the kernel doesn't seem to have any
> effect apart from changing the word "removed" to "obsolete" in the above
> messages.

Thanks.

Eric, that tends to make the whole idea inviable, doesn't it?
