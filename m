Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVCUASB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVCUASB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Mar 2005 19:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVCUASB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Mar 2005 19:18:01 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:23456 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S261402AbVCUAR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Mar 2005 19:17:58 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Suspend-to-disk woes
In-Reply-To: <1111364066.9720.2.camel@desktop.cunningham.myip.net.au>
References: <423B01A3.8090501@gmail.com> <20050319132612.GA1504@openzaurus.ucw.cz> <200503191220.35207.rmiller@duskglow.com> <20050319212922.GA1835@elf.ucw.cz> <20050319212922.GA1835@elf.ucw.cz> <1111364066.9720.2.camel@desktop.cunningham.myip.net.au>
Date: Mon, 21 Mar 2005 00:17:57 +0000
Message-Id: <E1DDAcH-0002n5-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham <ncunningham@cyclades.com> wrote:

> Yuck! Why panic when you know what is needed? A better solution is to
> tell the user they've messed up and given them the option to (1) reboot
> and try another kernel or (2) have swsusp restore the original swap
> signature and continue booting. This is what suspend2 does (with a
> timeout for the prompt). It's not that hard.

It's trivial to do this in userspace - just have an app in initramfs
that checks for a swsusp signature, and then compare the kernel
versions. If they mismatch, prompt for what to do. Putting it in the
kernel is madness.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
