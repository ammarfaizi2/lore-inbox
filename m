Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWAJMdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWAJMdX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 07:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWAJMdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 07:33:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2956 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750793AbWAJMdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 07:33:22 -0500
Date: Tue, 10 Jan 2006 04:33:00 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: 2.6.15-mm2 : Badness in __mutex_unlock_slowpath
Message-Id: <20060110043300.7edff1f7.akpm@osdl.org>
In-Reply-To: <9a8748490601100419s43233d74tf6e1a9f3e7a557f1@mail.gmail.com>
References: <9a8748490601100419s43233d74tf6e1a9f3e7a557f1@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <jesper.juhl@gmail.com> wrote:
>
> Just got this in dmesg a little while ago with 2.6.15-mm2 :
> 
>  [ 9294.769000] Badness in __mutex_unlock_slowpath at kernel/mutex.c:214
>  [ 9294.769000]  [<c0103e77>] dump_stack+0x17/0x20
>  [ 9294.769000]  [<c031c1a0>] __mutex_unlock_slowpath+0x220/0x260
>  [ 9294.769000]  [<c031bb0b>] mutex_unlock+0xb/0x10
>  [ 9294.769000]  [<f8e185d7>] snd_pcm_oss_write+0x37/0x70 [snd_pcm_oss]
>  [ 9294.769000]  [<c0165a7a>] vfs_write+0x8a/0x160
>  [ 9294.769000]  [<c0165bfd>] sys_write+0x3d/0x70
>  [ 9294.769000]  [<c0103009>] syscall_call+0x7/0xb

That's the alsa breakage - fixed now.
