Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262972AbVCKARS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbVCKARS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 19:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbVCKAQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 19:16:44 -0500
Received: from rproxy.gmail.com ([64.233.170.197]:30441 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263015AbVCKAKa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 19:10:30 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=GzXsaV+7NTxvAVTRcxSxUVAP5hPgqhyqSxo7+bvBNmQbJ+lX4dtsheZhJo3JzgikjkqB9isXi6QTzLN9uMlMwiXJA+zAaPuvVSWV8X8GtM4McOmWV2PFKblziS6dw0J3exggS3ck1gn7kl8JC1Tu8zfU7mXpZpV6bmGaxRiHa4A=
Message-ID: <5a2cf1f6050310161085f2da6@mail.gmail.com>
Date: Fri, 11 Mar 2005 01:10:30 +0100
From: jerome lacoste <jerome.lacoste@gmail.com>
Reply-To: jerome lacoste <jerome.lacoste@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: oops / 2.6.11 / run_timer_softirq (mountvirtfs)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On an VIA EPIA board, I got this single oops at boot. Wasn't stored on
file so I had to take a screenshot with a digital camera. Basicallly
goes along those lines:

Process: S36mountvirtfs

Call trace:
     run_timer_softirq+0x16f/0x200
     __do_softirq
     do_softirq
     irq_exit
     do_IRQ
     common_interrupt

Process is found here on my system:

lrwxr-xr-x  1 root root 21 Mar  1 00:29 /etc/rcS.d/S36mountvirtfs ->
../init.d/mountvirtfs

The exact screenshot (500k) can be found here:

http://coffeebreaks.dyndns.org/~jerome/static/images/linux/oops_2.6.11_run_timer_softirq_boot.jpg

I can spend time copying the input into a file and doing the ksymoops
stuff if someone wants to get it.
Otherwise I will go back to try fixing the other problems that happens
much more often...

J
