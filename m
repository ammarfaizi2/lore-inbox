Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbTJOEJk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 00:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbTJOEJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 00:09:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:21182 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262068AbTJOEJi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 00:09:38 -0400
Date: Tue, 14 Oct 2003 21:13:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org, clock@twibright.com
Subject: Re: Vortex 3c900 passing driver parameters
Message-Id: <20031014211316.64c7eeb9.akpm@osdl.org>
In-Reply-To: <20031014205702.140b6476.rddunlap@osdl.org>
References: <20031014205702.140b6476.rddunlap@osdl.org>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> Andrew Morton wrote:
> | Karel Kulhavý <clock@twibright.com> wrote:
> | >
> | > Hello
> | > 
> | > How do I do a ether=... (kernel boot-time) equivalent of
> | > insmod 3c59x.o options=0x201 full_duplex=1 ?
> | 
> | Unfortunately you cannot.  `ether=' is broken for all drivers which use the
> | new(ish) alloc_etherdev() API.
> | 
> | It is due to ordering problems: the name of the interface is not known at
> | the time of parsing the setup info and nobody has got down and worked out
> | how to fix it.
> 
> Does this ordering problem apply to both 2.4.current and 2.6.0-test?

Well it was a problem a year or so ago.

But init_netdev()'s call to netdev_boot_setup_check() looks like it
should fix things up, so I'm not sure what's going on...

