Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272233AbTGaAsc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 20:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272239AbTGaAsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 20:48:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:10913 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272233AbTGaAsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 20:48:31 -0400
Date: Wed, 30 Jul 2003 17:36:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: root <root@rachel.trevorj.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Major 2.4 / 2.{5|6}-smp Scheduler Slow-ness
Message-Id: <20030730173644.06d86b2a.akpm@osdl.org>
In-Reply-To: <20030731002727.GA3827@rachel.trevorj.com>
References: <20030731002727.GA3827@rachel.trevorj.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

root <root@rachel.trevorj.com> wrote:
>
> Ok, first of all, I have never been able to run a 2.4 kernel on this 
> machine, it runs _very_ slow. By slow, i mean it takes literally HOURS 
> to boot. I have tried 2.4.20,2.4.21, and also both with the openmosix 
> patches.
> 
> Now, the 2.5/6 kernel runs beautifully, so i have been running both 
> vanilla, and vanilla+mm patches, both run fine. Although, using the smp 
> scheduler makes it do the exact same thing as 2.4, albeit a little 
> faster. So this leads me into thinking *very* 
> much so that this is a scheduler issue.

boot with "profile=1", learn to use readprofile, post the results.


irq 21: nobody cared!
...
handlers:
[<c8a37620>] (snd_emu10k1_interrupt+0x0/0x3f0 [snd_emu10k1])
Disabling IRQ #21

This is fishy.  Try removing the sound driver from the kernel altogether. 
And any other unneeded-to-boot drivers, come to that.

