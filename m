Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266002AbUF2UDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266002AbUF2UDQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 16:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUF2UDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 16:03:16 -0400
Received: from mail.gmx.de ([213.165.64.20]:18563 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266002AbUF2UDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 16:03:13 -0400
X-Authenticated: #1892127
Mime-Version: 1.0 (Apple Message framework v618)
Content-Transfer-Encoding: 7bit
Message-Id: <59A9EBDA-CA07-11D8-99AE-0003931E0B62@gmx.li>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linux-kernel@vger.kernel.org
From: Martin Schaffner <schaffner@gmx.li>
Subject: building on case-insensitive file systems
Date: Tue, 29 Jun 2004 22:03:12 +0200
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Building linux-2.6.7 on a case-insensitive filesystem is currently not  
possible, because the build system requires the two files:
arch/$(ARCH)/kernel/vmlinux.lds.s
arch/$(ARCH)/kernel/vmlinux.lds.S
whose filename differ only in case.

Here is a patch which fixes this, by changing the build system to  
use"vmlinux.lds.asm" instead of "vmlinux.lds.s":
http://mirror.vtx.ch/lfs/patches/downloads/linux/linux-2.6.7- 
build_on_case_insensitive_fs-1.patch

Please consider applying.

Thanks,

Martin Schaffner

