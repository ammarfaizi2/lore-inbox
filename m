Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266284AbUHHUqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266284AbUHHUqM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 16:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266291AbUHHUqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 16:46:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:62154 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266284AbUHHUqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 16:46:09 -0400
Date: Sun, 8 Aug 2004 13:44:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Juergen Pabel <jpabel@akkaya.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Masking kernel commandline parameters (2.6.7)
Message-Id: <20040808134432.678629d0.akpm@osdl.org>
In-Reply-To: <200408080413.29905.jpabel@akkaya.de>
References: <200408080413.29905.jpabel@akkaya.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen Pabel <jpabel@akkaya.de> wrote:
>
> my patch allows for kernel commandline parameters (ie: from bootloader) to be masked in order to 
>  prevent later retrieval (/proc/cmdline for example).

In recent 2.6 kernels you can simply do a chmod on /proc/cmdline.

bix:/usr/src/bk25> cat /proc/cmdline
ro root=/dev/sda2 profile=1 vga=extended
bix:/usr/src/bk25> 0 chmod 0400 /proc/cmdline
bix:/usr/src/bk25> cat /proc/cmdline         
cat: /proc/cmdline: Permission denied

