Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261612AbUKISfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261612AbUKISfW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 13:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261613AbUKISfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 13:35:22 -0500
Received: from hera.kernel.org ([63.209.29.2]:60582 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261612AbUKISfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 13:35:12 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: 2.6.9 RCU breakage in dev_queue_xmit
Date: Tue, 9 Nov 2004 10:37:32 -0800
Organization: Open Source Development Lab
Message-ID: <20041109103732.6422f138@zqx3.pdx.osdl.net>
References: <4190FFE9.8000203@drdos.com>
	<419108ED.9090608@trash.net>
	<41910F1A.8070305@drdos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1100025303 26181 172.20.1.73 (9 Nov 2004 18:35:03 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Tue, 9 Nov 2004 18:35:03 +0000 (UTC)
X-Newsreader: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i686-suse-linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Nov 2004 11:40:26 -0700
"Jeff V. Merkey" <jmerkey@drdos.com> wrote:

> Patrick McHardy wrote:
> 
> > Jeff V. Merkey wrote:
> >
> >>
> >> Running dual gigabit interfaces at 196 MB/S (megabytes/second) on 
> >> receive, 12 CLK interacket gap time, 1500 bytes payload
> >> at 65000 packets per second per gigabit interface, and retransmitting 
> >> received packets at 130 MB/S out of a third gigabit interface
> >> with skb, RCU locks in dev_queue_xmit breaks and enters the following 
> >> state:
> >>
> >> Nov  8 15:38:08 ds kernel: Badness in local_bh_enable at 
> >> kernel/softirq.c:141
> >> Nov  8 15:38:08 ds kernel:  [<40107d1e>] dump_stack+0x1e/0x30
> >> Nov  8 15:38:08 ds kernel:  [<401218b0>] local_bh_enable+0x70/0x80
> >> Nov  8 15:38:08 ds kernel:  [<402c5bbb>] dev_queue_xmit+0x11b/0x250
> >> Nov  8 15:38:08 ds kernel:  [<f8981cb7>] xmit_skb+0x17/0x20 [dsfs]
> >> Nov  8 15:38:08 ds kernel:  [<f8981f8e>] xmit_packet+0x2e/0x80 [dsfs]
> >> Nov  8 15:38:08 ds kernel:  [<f89820eb>] regen_data+0x10b/0x290 [dsfs]
> >
> >
> > There is no such function in the 2.6.9 kernel.
> 
> 
> Check /include/linux for local_bh_enable and /net/core/dev.c .
> 
> Jeff
> 
> >
> > Regards
> > Patrick

Patrick is asking about the function regen_data which doesn't exist in the
standard kernel.
