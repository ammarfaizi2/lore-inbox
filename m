Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269656AbUIRW7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269656AbUIRW7q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 18:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269658AbUIRW7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 18:59:46 -0400
Received: from vaugirard-3-81-57-244-9.fbx.proxad.net ([81.57.244.9]:30598
	"EHLO Laptop") by vger.kernel.org with ESMTP id S269656AbUIRW7o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 18:59:44 -0400
Message-ID: <414CBCE0.5000508@free.fr>
Date: Sun, 19 Sep 2004 00:55:28 +0200
From: Cyril Wattebled <neurowork@free.fr>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: init_tss problem
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm trying to understand some piece of kernel code and I've come to this :
In arch/i386/kernel/process.c:
	struct tss_struct *tss = &per_cpu(init_tss, cpu);
I don't know what init_tss is.
It's defined in asm/processor.h with the macro DEFINE_PER_CPU 
(tss_struct, init_tss)
which basically does extern tss_struct init_tss.
But this init_tss has to be declared somewhere to be used as extern ...
I've searched the entire code for any reference to it but I only found it in
arch/x86_64/kernel/init_task.c which is normaly not compiled on my system.
I'm in a dead end ... anyone .. help ?
Thanks
-- 
Cyril Wattebled
neurowork@free.fr
