Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269342AbUJLA40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269342AbUJLA40 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 20:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269410AbUJLAyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 20:54:33 -0400
Received: from main.gmane.org ([80.91.229.2]:63678 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269396AbUJLAqh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 20:46:37 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jack Byer <ojbyer@usa.net>
Subject: Re: 2.6.9-rc4-mm1
Date: Mon, 11 Oct 2004 20:32:28 -0400
Message-ID: <ckf9h6$j40$1@sea.gmane.org>
References: <20041011032502.299dc88d.akpm@osdl.org>	<cke3fj$eoh$1@sea.gmane.org> <20041011145838.051c1a9d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 69.37.187.166.adsl.snet.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040927
X-Accept-Language: en-us, en
In-Reply-To: <20041011145838.051c1a9d.akpm@osdl.org>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Even thought the help for CONFIG_INITRAMFS_SOURCE says to leave blank, I 
was eventually able to get it to compile by setting 
CONFIG_INITRAMFS_SOURCE="/usr/src/linux/usr/initramfs_list".

I thought about it later and maybe having KBUILD_OUTPUT set caused the 
problem in the first place.

Unfortunately, I couldn't test this because I made my system unbootable 
with a new ivtv module :(

Andrew Morton wrote:

 > Please don't remove me from Cc:
 >
 > Jack Byer <ojbyer@usa.net> wrote:
 >
 >> When I try to compile this kernel, I get the following error:
 >>
 >>   Using /usr/src/linux-2.6.9-rc4-mm1 as source for kernel
 >>   CHK     include/linux/version.h
 >> make[2]: `arch/i386/kernel/asm-offsets.s' is up to date.
 >>   CHK     include/asm-i386/asm_offsets.h
 >>   CHK     include/linux/compile.h
 >>   GEN_INITRAMFS_LIST usr/initramfs_list
 >> Using shipped usr/initramfs_list
 >>   CPIO    usr/initramfs_data.cpio
 >> ERROR: unable to open 'usr/initramfs_list': No such file or directory
 >
 >
 >
 > You need to create usr/initramfs_list.
 >
 > Thayne, some documentation would be nice.
 >

