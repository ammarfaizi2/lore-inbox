Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751507AbWANOFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbWANOFT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 09:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWANOFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 09:05:19 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5019 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751431AbWANOFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 09:05:17 -0500
Date: Sat, 14 Jan 2006 06:04:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6.15] running tcpdump on 3c905b causes freeze (reproducable)
Message-Id: <20060114060457.06efae88.akpm@osdl.org>
In-Reply-To: <20060114132414.GN6087@vanheusden.com>
References: <20060108114305.GA32425@vanheusden.com>
	<20060109041114.6e797a9b.akpm@osdl.org>
	<20060109144522.GB10955@vanheusden.com>
	<20060109193754.GD12673@vanheusden.com>
	<20060109224821.7a40bc69.akpm@osdl.org>
	<20060110142725.GH12673@vanheusden.com>
	<20060114132414.GN6087@vanheusden.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folkert van Heusden <folkert@vanheusden.com> wrote:
>
>  > > > > > Have you tried enabling the NMI watchdog?  Enable CONFIG_X86_LOCAL_APIC and
>  > > > > > boot with `nmi_watchdog=1' on the command line, make sure that the NMI line
>  > > > > > of /proc/interrupts is incrementing.
>  > > > > I'll give it a try. I've added it to the append-line in the lilo config.
>  > > > > Am now compiling the kernel.
>  > > > No change. Well, that is: the last message on the console now is
>  > > > "setting eth1 to promiscues mode".
>  > > Did you confirm that the NMI counters in /proc/interrupts are incrementing?
>  > Yes:
>  > root@muur:/home/folkert# for i in `seq 1 5` ; do cat /proc/interrupts  | grep NMI ; sleep 1 ; done
>  > NMI:    6949080    6949067
>  > NMI:    6949182    6949169
>  > NMI:    6949284    6949271
>  > NMI:    6949386    6949373
>  > NMI:    6949488    6949475
> 
>  Is there anything else I can try?

argh.   I haven't forgotten.  Hopefully after -rc1 I'll have more time...

Your report didn't mention whether that card work OK under earlier 2.6
kernels.  If it does, a bit of bisection searching would really help.
