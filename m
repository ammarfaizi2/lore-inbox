Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265539AbTIDVz5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 17:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265548AbTIDVz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 17:55:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:40595 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265539AbTIDVzx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 17:55:53 -0400
Date: Thu, 4 Sep 2003 14:38:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Florian Zimmermann <florian.zimmermann@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test-x] Kernel Oops and pppd segfault
Message-Id: <20030904143850.461467c6.akpm@osdl.org>
In-Reply-To: <1062711059.8011.4.camel@mindfsck>
References: <1062711059.8011.4.camel@mindfsck>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Zimmermann <florian.zimmermann@gmx.net> wrote:
>
> I have posted that to linux-ppp mailing list, but
> no answer for 2 weeks now..

Slack Australians.

> and here comes the Oops when i want to start 'pppd':
> 
> PPP generic driver version 2.4.2
> devfs_mk_cdev: could not append to parent for ppp
> failed to register PPP device (-17)

_devfs_append_entry("ppp") returns -EEXIST.

> Unable to handle kernel paging request at virtual address d1964580
> EIP is at cdev_get+0x29/0xc0

Then it looks like someone didn't handle the error right.

Please:

a) send your full .config

b) describe the exact sequence of steps which is required to make this
   happen, starting from a machine reboot.

Does a simple "modprobe ppp" fail?


