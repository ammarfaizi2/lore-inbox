Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbVLAMSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbVLAMSk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 07:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbVLAMSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 07:18:40 -0500
Received: from mail.charite.de ([160.45.207.131]:16530 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S932179AbVLAMSj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 07:18:39 -0500
Date: Thu, 1 Dec 2005 13:18:27 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc4
Message-ID: <20051201121826.GF19694@charite.de>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0511302234020.3099@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0511302234020.3099@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds <torvalds@osdl.org>:

> [ Btw, some drivers will now complain loudly about their nasty mis-use of 
>   page remapping, and that migh look scary, but it should all be good, and 
>   we'd love to see the detailed output of dmesg on such machines. ]

Here's one - smite me for using the nvidia driver:

Xorg does an incomplete pfn remapping [<c013eb8c>] incomplete_pfn_remap+0x6b/0xca
 [<f94fc956>] nv_kern_mmap+0x47d/0x4cb [nvidia]
 [<c01415e1>] do_mmap_pgoff+0x3cf/0x6ee
 [<c0107dea>] sys_mmap2+0x66/0xaf
 [<c0102c25>] syscall_call+0x7/0xb

repeated 4 times.

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
