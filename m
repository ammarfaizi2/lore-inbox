Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266003AbUIIUnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266003AbUIIUnh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 16:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266069AbUIIUnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 16:43:37 -0400
Received: from fw.osdl.org ([65.172.181.6]:32200 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266003AbUIIUng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 16:43:36 -0400
Date: Thu, 9 Sep 2004 13:40:47 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: mingo@elte.hu, zwane@linuxpower.ca, hch@infradead.org, wli@holomorphy.com,
       linux-kernel@vger.kernel.org, scott@timesys.com, arjanv@redhat.com
Subject: Re: [patch] generic-hardirqs-2.6.9-rc1-mm4.patch
Message-Id: <20040909134047.41aab7a4.akpm@osdl.org>
In-Reply-To: <200409092224.49690.rjw@sisk.pl>
References: <20040908120613.GA16916@elte.hu>
	<20040908182509.GA6009@elte.hu>
	<20040908211415.GA20168@elte.hu>
	<200409092224.49690.rjw@sisk.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>
> I've got this trace (on x86-64):
> 
>  general protection fault: 0000 [1] PREEMPT
>  CPU 0
>  Modules linked in: usbserial parport_pc lp parport joydev sg st sd_mod sr_mod 
>  scsi_mod snd_seq_oss snd_seq_midi_evend
>  Pid: 694, comm: kjournald Not tainted 2.6.9-rc1-mm4
>  RIP: 0010:[<ffffffff802ac605>] 
>  <ffffffff802ac605>{__journal_clean_checkpoint_list+389}

You should revert
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6.9-rc1-mm4/broken-out/journal_clean_checkpoint_list-latency-fix.patch
- it seems to be sick.
