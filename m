Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262384AbTA2CAb>; Tue, 28 Jan 2003 21:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262394AbTA2B7u>; Tue, 28 Jan 2003 20:59:50 -0500
Received: from packet.digeo.com ([12.110.80.53]:19439 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262384AbTA2B7i>;
	Tue, 28 Jan 2003 20:59:38 -0500
Date: Tue, 28 Jan 2003 18:09:09 -0800
From: Andrew Morton <akpm@digeo.com>
To: Chuck Burns <zex0s@mchsi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre3 and 3com Integrated 3C556B (3c59x module)
Message-Id: <20030128180909.69ea049e.akpm@digeo.com>
In-Reply-To: <200301281949.45510.zex0s@mchsi.com>
References: <200301281949.45510.zex0s@mchsi.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Jan 2003 02:08:50.0799 (UTC) FILETIME=[5DA68FF0:01C2C73B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Burns <zex0s@mchsi.com> wrote:
>
> Having recently upgraded my Mandrake 9.0 Laptop to the latest Mandrake cooker 
> (9.1beta) it uses the 2.4.21pre3 kernel.  A problem has occured somewhere 
> between 2.4.19 and 2.4.21pre3, with regards to the 3c59x driver module.  It 
> incorrectly returns the MAC address for my IBM Thinkpad a20m with 3com 
> integrated PCI 10/100M ethernet/Modem combo card. (the Nic is a 3com 3c556b, 
> which is supported under the 3c59x module)  The 2.4.19 kernel module 
> accurately reports the MAC address.
> 
> The 2.4.21pre3 MAC address reported for my card is FF:FF:FF:FF:FF:FF,
> which, obviously, is incorrect.  I have never submitted a bug report before, 
> so I am not quite sure what all information you need.. there is no error 
> message associated with this

Yup, seen a couple of these.  It appears that the PCI and/or Cardbus code
broke the 3com driver.

Please send the full `dmesg' output so we can see the kernel boot messages
and also the `lspci -vx -s' output for that device.

