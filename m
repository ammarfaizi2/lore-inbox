Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbUCJXE1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 18:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262867AbUCJXDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 18:03:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43994 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262258AbUCJXBp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 18:01:45 -0500
Message-ID: <404F9E4D.4040908@pobox.com>
Date: Wed, 10 Mar 2004 18:01:33 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rene Herman <rene.herman@keyaccess.nl>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 8139too Interframe Gap Time
References: <404F9B4B.5050803@keyaccess.nl>
In-Reply-To: <404F9B4B.5050803@keyaccess.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Herman wrote:
> Hi Jeff,
> 
> in drivers/net/8139too.c, we have:
> 
>    /* Check this value: the documentation for IFG contradicts ifself. */
>    RTL_W32 (TxConfig, rtl8139_tx_config);
> 
> I see that in older versions of the documentation there indeed were some
> contradictions but the current version 1.4:
> 
> ftp://210.51.181.211/cn/nic/rtl8139abcd8130810xseries/rtl8139cspec_1.4.pdf
> 
> clears it up and it seems 8139too guessed wrong. I have verified that
> realtek's own windows 9x driver agrees with the documentation.
> 
> No equipment to actually measure the IFG and no difference in network
> behaviour shows up on a good 100Mbit-FD switch connected LAN, but it
> does on an el-cheapo 10Mbit-HD hub connected LAN. Without attached
> patch the packet and collision counters are basically the same; with
> patch, the latter is only some 70% of the former. Hurray!


Nice!

I'm glad somebody finally got around to doing this :)

I'll give this some testing (and put it in Andrew's -mm for that reason 
as well), and then apply it.

Thanks,

	Jeff



