Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWBLX01@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWBLX01 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 18:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751073AbWBLX01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 18:26:27 -0500
Received: from mail.gmx.de ([213.165.64.21]:9603 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751060AbWBLX01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 18:26:27 -0500
X-Authenticated: #9163084
Date: Mon, 13 Feb 2006 00:27:06 +0100
From: Marko <letterdrop@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: How getting a pointer on the per-cpu struct tss_struct??
Message-Id: <20060213002706.50e5289c.letterdrop@gmx.de>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

may anyone tell me where I'm wrong???


What I thought to have found:

I want to access the per-cpu IO Permission Bitmap. Therefore, I try to
get a pointer on the per-cpu struct tss_struct. I found an array of typ
'struct tss_struct' named 'init_tss' (declared in asm/processor.h with
'DECLARE_PER_CPU(struct tss_struct, init_tss);').

So I should be able to get a pointer on the struct tss_struct of the
current cpu, by using the following code:

	int cpu = get_cpu();
	struct tss_struct * t = &per_cpu(init_tss, cpu);

But when I try to compile this, I get the warning:

	*** Warning: "per_cpu__init_tss" [/home/..../module.ko]
	undefined!

and according to this warning an error, when I try to load the module:

	insmod: error inserting 'module.ko': -1 Unknown symbol in module


(I'm using gcc4.0.2 and kernel 2.6.14.2)


Where's my problem??

Thanks,



Marko Euth
