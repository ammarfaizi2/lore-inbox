Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263515AbUJ2WwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263515AbUJ2WwZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 18:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbUJ2Wsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 18:48:31 -0400
Received: from fire.osdl.org ([65.172.181.4]:31919 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S263537AbUJ2Wnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 18:43:49 -0400
Message-ID: <4182C52F.20301@osdl.org>
Date: Fri, 29 Oct 2004 15:33:19 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1-mm2 (badness)
References: <20041029014930.21ed5b9a.akpm@osdl.org>
In-Reply-To: <20041029014930.21ed5b9a.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc1/2.6.10-rc1-mm2/

I am seeing 2 badness reports with $Subject:

kobject i823650: cleaning up
Device 'i823650' does not have a release() function, it is broken and 
must be f.
Badness in device_release at drivers/base/core.c:85
  [<c0106e09>] dump_stack+0x1e/0x20
  [<c0218619>] kobject_cleanup+0x94/0x96
  [<c021906b>] kref_put+0x49/0xaa
  [<c0218648>] kobject_put+0x20/0x22
  [<c057841a>] init_i82365+0x1e0/0x1f6
  [<c055a981>] do_initcalls+0x27/0xc0
  [<c010050c>] init+0x7d/0x19c
  [<c0104295>] kernel_thread_helper+0x5/0xb
kobject i82365: unregistering

&&

Badness in enable_irq at kernel/irq/manage.c:106
  [<c0106e09>] dump_stack+0x1e/0x20
  [<c013f767>] enable_irq+0x72/0xd9
  [<c02b0416>] e100_up+0xfe/0x20a
  [<c02b15ca>] e100_open+0x26/0x6e
  [<c0396816>] dev_open+0x6e/0x7c
  [<c0397d85>] dev_change_flags+0x56/0x126
  [<c03d23a6>] devinet_ioctl+0x60b/0x6cd
  [<c03d41e1>] inet_ioctl+0x81/0xae
  [<c038dd3c>] sock_ioctl+0x1d3/0x2d6
  [<c0172920>] sys_ioctl+0x179/0x21d
  [<c0105f5d>] sysenter_past_esp+0x52/0x71
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex

Dual-P4, IDE, 1 GB RAM.
.config at:
http://developer.osdl.org/rddunlap/configs/config-2610rc1mm2

-- 
~Randy
