Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269218AbUJQRiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269218AbUJQRiV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 13:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269221AbUJQRiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 13:38:21 -0400
Received: from mail.gmx.de ([213.165.64.20]:44961 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S269218AbUJQRiQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 13:38:16 -0400
X-Authenticated: #4399952
Date: Sun, 17 Oct 2004 19:53:58 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@Raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U4
Message-ID: <20041017195358.4e473893@mango.fruits.de>
In-Reply-To: <20041017165509.GA26791@elte.hu>
References: <20041012091501.GA18562@elte.hu>
	<20041012123318.GA2102@elte.hu>
	<20041012195424.GA3961@elte.hu>
	<20041013061518.GA1083@elte.hu>
	<20041014002433.GA19399@elte.hu>
	<20041014143131.GA20258@elte.hu>
	<20041014234202.GA26207@elte.hu>
	<20041015102633.GA20132@elte.hu>
	<20041016153344.GA16766@elte.hu>
	<20041017190330.7a226190@mango.fruits.de>
	<20041017165509.GA26791@elte.hu>
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2004 18:55:09 +0200
Ingo Molnar <mingo@elte.hu> wrote:

> ok, does the patch below fix those messages? (gameport.c used its own,
> private, incompatible prototype for i8253_lock which breaks raw spinlock
> handling.)
> 

it seems to fix it. i don't see any more messages like the reported anymore.
snd-cs46xx might have some other issues though: Upon rmmod snd-cs46xx i see:

Oct 17 19:43:04 mango kernel: Sound Fusion CS46xx 0000:00:0f.0: Device was removed without properly calling pci_disable_device(). This may need fixing.

but i should probably report that to alsa-devel instead right?

flo
