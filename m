Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269422AbUICQbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269422AbUICQbN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 12:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269366AbUICQav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 12:30:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:21425 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269416AbUICQ3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 12:29:20 -0400
Date: Fri, 3 Sep 2004 09:27:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc1-mm3
Message-Id: <20040903092721.6e9ec255.akpm@osdl.org>
In-Reply-To: <200409031215.06062.norberto+linux-kernel@bensa.ath.cx>
References: <20040903014811.6247d47d.akpm@osdl.org>
	<200409031215.06062.norberto+linux-kernel@bensa.ath.cx>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norberto Bensa <norberto+linux-kernel@bensa.ath.cx> wrote:
>
> Andrew Morton wrote:
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc1/2.6
>  >.9-rc1-mm3/
> 
>  Same behavior than -mm2, KDE doesn't start: hangs at kbuildsycoca or kcminit 
>  with status D. No crash. No oops.

When it has hung, please do:

	dmesg -c
	echo t > /proc/sysrq-trigger
	dmesg -s 1000000 > foo

and then send foo, making sure that it doesn't get wordwrapped
in transit.

Thanks.
