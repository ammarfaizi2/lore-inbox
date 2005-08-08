Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbVHHXTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbVHHXTq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 19:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbVHHXTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 19:19:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43154 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932355AbVHHXTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 19:19:45 -0400
Date: Mon, 8 Aug 2005 16:18:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: <art@usfltd.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: Linux-2.6.13-rc6: aic7xxx testers please..-deadlock
Message-Id: <20050808161813.7047197c.akpm@osdl.org>
In-Reply-To: <200508081245.AA36831876@usfltd.com>
References: <200508081245.AA36831876@usfltd.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"art" <art@usfltd.com> wrote:
>
> kernel 2.6.13-rc1-git7 to 2.6.13-rc5 transfer 72MB/s on aha19160 with 15k
> rpm seagate with reiserfs3 but possible deadlock in heavy IO - rsync
> ~50000-small files from /mnt/seagate15k/a to /mnt/seagate15k/b ends in
> middle with deadlock of rsync (3 instances), pdflush, and gam_server all
> of them in uninteruptible state -- root cannot kill this deadlocked
> uninterruptibles, so reboot by reset

Please ensure that CONFIG_MAGIC_SYSRQ=y amd that /proc/sysrq is 1 and when
the deadlock happens, do ALT-SYSRQ-T or `echo t > /proc/sysrq-trigger' then
get us the output of `dmesg -s 1000000', thanks.

