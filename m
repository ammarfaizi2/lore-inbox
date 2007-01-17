Return-Path: <linux-kernel-owner+w=401wt.eu-S932280AbXAQONq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932280AbXAQONq (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 09:13:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbXAQONq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 09:13:46 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:57678 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932280AbXAQONp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 09:13:45 -0500
Date: Wed, 17 Jan 2007 15:12:23 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alon Bar-Lev <alon.barlev@gmail.com>
cc: Tomasz Chmielewski <mangoo@wpkg.org>, linux-kernel@vger.kernel.org
Subject: Re: kernel cmdline: root=/dev/sdb1,/dev/sda1 "fallback"?
In-Reply-To: <9e0cf0bf0701170606x32e701e7i460aba13a2ae5bfd@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0701171511070.18562@yvahk01.tjqt.qr>
References: <45AE1D65.4010804@wpkg.org>  <9e0cf0bf0701170537s4bb663a1j2d45b4013da81fbc@mail.gmail.com>
  <45AE2AF3.5070706@wpkg.org> <9e0cf0bf0701170606x32e701e7i460aba13a2ae5bfd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 17 2007 16:06, Alon Bar-Lev wrote:
> On 1/17/07, Tomasz Chmielewski <mangoo@wpkg.org> wrote:
>> Another obstacle would be to place the initramfs image on the same
>> partition as the kernel (normally, I dd kernel to /dev/mtd1).
>
> As far as I know you can embed the initramfs into the kernel image using
> CONFIG_INITRAMFS_SOURCE.
>
> http://www.timesys.com/timesource/initramfs.htm

The question was rather if
  (a) kernel code is cheaper than
  (b) userspace

And I say: neither. If things get really tight, write your own
init.c, compile with -static and link against uclibc/klibc, and let
it hopefully be small enough to fit.


	-`J'
-- 
