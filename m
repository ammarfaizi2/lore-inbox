Return-Path: <linux-kernel-owner+w=401wt.eu-S932494AbXAGLEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932494AbXAGLEt (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 06:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbXAGLEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 06:04:49 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:35972 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932494AbXAGLEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 06:04:48 -0500
Date: Sun, 7 Jan 2007 12:03:58 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Amit Choudhary <amit2030@yahoo.com>
cc: Rene Herman <rene.herman@gmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [DISCUSS] Making system calls more portable.
In-Reply-To: <647618.57006.qm@web55614.mail.re4.yahoo.com>
Message-ID: <Pine.LNX.4.61.0701071156430.4365@yvahk01.tjqt.qr>
References: <647618.57006.qm@web55614.mail.re4.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 7 2007 01:07, Amit Choudhary wrote:
>
>I will come to the main issue later but I just wanted to point out
>that we maintain information at two separate places - mapping
>between the name and the number in user space and kernel space.
>Shouldn't this duplication be removed.

For example? Do you plan on using "syscall strings" instead of
syscall numbers? I would not go for it. Comparing strings takes much
longer than comparing a register-size integer.

>Now, let's say a vendor has linux_kernel_version_1 that has 300
>system calls. The vendor needs to give some extra functionality to
>its customers and the way chosen is to implement new system call.
>The new system call number is 301. [...]

Umm, like with Internet addresses, you can't just reserve yourself
one you like. Including MACs on the local ethernet segment. Though
the MAC space is large with 2^48 or more, you can ARP spoof and
hinder the net.
In other words, if the vendor, or you, are going to use a
non-standard 301, you are supposed to run into problems, sooner or
later [Murphy's Law or Finagle's Corollary].
What you probably want is a syscall number range marked for private
use, much like there is for majors in /dev or 10.0.0.0/8 on inet.


	-`J'
-- 
