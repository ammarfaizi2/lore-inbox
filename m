Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbVILWPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbVILWPF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 18:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbVILWPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 18:15:05 -0400
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:6849 "EHLO
	gw02.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S932299AbVILWPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 18:15:02 -0400
From: Nuutti Kotivuori <naked@iki.fi>
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netfilter QUEUE target and packet socket interactions buggy or not
References: <87fysa9bqt.fsf@aka.i.naked.iki.fi>
	<20050912.151120.104514011.davem@davemloft.net>
Date: Tue, 13 Sep 2005 01:34:59 +0300
In-Reply-To: <20050912.151120.104514011.davem@davemloft.net> (David
	S. Miller's message of "Mon, 12 Sep 2005 15:11:20 -0700 (PDT)")
Message-ID: <87br2xap9o.fsf@aka.i.naked.iki.fi>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.17 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> From: Nuutti Kotivuori <naked@iki.fi>
> Date: Tue, 13 Sep 2005 01:12:26 +0300
>
>> ,----
>> | Unable to handle kernel NULL pointer dereference at virtual address 00000018
>> | ...
>> |         __kfree_skb+0xf4/0xf7
>> |  [<c02c3188>] packet_rcv+0x2ca/0x2d4
>> |  [<f888f792>] bcm5700_start_xmit+0x477/0x4a5 [bcm5700]
>
> Please use the tg3 driver that actually comes with
> the kernel :-)

The problem also appears with the tg3 driver. In some other crashes,
the traceback looks like:

,----
|         __kfree_skb+0xf4/0xf7
|  [<c02c3188>] packet_rcv+0x2ca/0x2d4
|  [<c0273ca8>] dev_queue_xmit_nit+0xc1/0xd3
|  [<c01a3a02>] selinux_ipv4_postroute_last+0xf/0x13
`----

I am doubtful the network card driver would be at fault here, but
that'll be confirmed once I manage to narrow this down more.

-- Naked

