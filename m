Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbUKISOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbUKISOK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 13:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbUKISOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 13:14:09 -0500
Received: from [62.206.217.67] ([62.206.217.67]:64464 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261600AbUKISOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 13:14:06 -0500
Message-ID: <419108ED.9090608@trash.net>
Date: Tue, 09 Nov 2004 19:14:05 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041008 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@drdos.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 RCU breakage in dev_queue_xmit
References: <4190FFE9.8000203@drdos.com>
In-Reply-To: <4190FFE9.8000203@drdos.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:

>
> Running dual gigabit interfaces at 196 MB/S (megabytes/second) on 
> receive, 12 CLK interacket gap time, 1500 bytes payload
> at 65000 packets per second per gigabit interface, and retransmitting 
> received packets at 130 MB/S out of a third gigabit interface
> with skb, RCU locks in dev_queue_xmit breaks and enters the following 
> state:
>
> Nov  8 15:38:08 ds kernel: Badness in local_bh_enable at 
> kernel/softirq.c:141
> Nov  8 15:38:08 ds kernel:  [<40107d1e>] dump_stack+0x1e/0x30
> Nov  8 15:38:08 ds kernel:  [<401218b0>] local_bh_enable+0x70/0x80
> Nov  8 15:38:08 ds kernel:  [<402c5bbb>] dev_queue_xmit+0x11b/0x250
> Nov  8 15:38:08 ds kernel:  [<f8981cb7>] xmit_skb+0x17/0x20 [dsfs]
> Nov  8 15:38:08 ds kernel:  [<f8981f8e>] xmit_packet+0x2e/0x80 [dsfs]
> Nov  8 15:38:08 ds kernel:  [<f89820eb>] regen_data+0x10b/0x290 [dsfs]

There is no such function in the 2.6.9 kernel.

Regards
Patrick

