Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262207AbVAJLc5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbVAJLc5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 06:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbVAJLc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 06:32:57 -0500
Received: from host181-209-dsl.dols.net.pk ([202.147.181.209]:33974 "EHLO
	1aurora.enabtech") by vger.kernel.org with ESMTP id S262207AbVAJLcv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 06:32:51 -0500
Message-ID: <1B701004057AF74FAFF851560087B1610646A3@1aurora.enabtech>
From: Mudeem Iqbal <mudeem@Quartics.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: mipsel-linux-ld:arch/mips/kernel/vmlinux.lds:468: parse error
Date: Mon, 10 Jan 2005 16:22:52 +0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello all

I have built a toolchain using the following combination

binutils-2.15.94.0.2
gcc-3.4.3
glibc-2.3.3
linux-2.6.9	(from linux-mips.org)

I am cross compiling linux kernel for mips. I think the toolchain has been
successfully built. But when cross compiling the kernel I get the following
error

LD	init/built-in.o
LD .tmp_vmlinux1
mipsel-linux-ld:arch/mips/kernel/vmlinux.lds:6: parse error
make: ***[.tmp_vmlinux1] Error 1

The vmlinux.lds generated is as follows

1) OUPUT_ARH(mips)
2) Entry(kernel_entry)
3) jiffies = jiffies_64;
4) SECTION
5) {
6)	. = ;
7)	/* rea-only */
8)	_text = .; /* Text and read only data *

	and so on........
	
}

The line indicated by the error is . = ; Any ideas

Thanks in advance

Mudeem
