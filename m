Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbTLPLks (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 06:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTLPLks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 06:40:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:27540 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261500AbTLPLkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 06:40:47 -0500
Date: Tue, 16 Dec 2003 03:40:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: crypto-loop + highmen -> random crashes in -test11
Message-Id: <20031216034059.28db8e91.akpm@osdl.org>
In-Reply-To: <1071570648.3528.50.camel@localhost>
References: <1071570648.3528.50.camel@localhost>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Soeren Sonnenburg <kernel@nn7.de> wrote:
>
> Hi.
> 
> I get random crashes/corruption/ init kills when I use cryptoloop on
> this highmem enabled ppc machine.

People have reported cryptoloop+highmem crashes on ia32 as well.  I'm not
sure if that was with -mm though.

> Applying the loop-* patches at
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test10/2.6.0-test10-mm1/broken-out
> 
> seem to fix this problem (at least I did not get any crash due to
> cryptoloop in the last 2 days)
>
> Steps to reproduce:
> 
> dd if=/dev/zero of=/file bs=1M count=100
> losetup -e blowfish /dev/loop0 /file
> Password:
> mkfs -t ext3 /dev/loop0
> mount /dev/loop0 /mnt
> cd /mnt  
> dd if=/dev/zero of=bla
> 
> gives you nice unpredictable crashes.
>

Nice, but I don't know why those patches fixed it. hrm.


