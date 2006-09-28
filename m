Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWI1Wie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWI1Wie (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 18:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWI1Wie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 18:38:34 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:7007 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750738AbWI1Wid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 18:38:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=QzIabXNCTlGBqmKj76ZAzdrbljSKpSdEg2JzcgJr0KaQT0nzT/g4XtyXT4L/7sqSIT2WdFniAZ2iIRqGGUcdk1z/Qs+KI0g6ZwNgcPUINj7LlBzXnLgIKGUYm9I2y5HTYtuKw4i7gS7ELseT6ayn3Tqq/gZ4pxLFVVn3CG5mXqw=
Message-ID: <451C4F0F.6010307@gmail.com>
Date: Thu, 28 Sep 2006 16:39:11 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Re: 2.6.18-mm2
References: <20060928014623.ccc9b885.akpm@osdl.org>
In-Reply-To: <20060928014623.ccc9b885.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[jimc@harpo linux-2.6.18-mm2-sk]$ make
  CHK     include/linux/version.h
  CHK     include/linux/utsrelease.h
  CHK     include/linux/compile.h
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/i386/kernel/built-in.o(.text+0x34f1): In function `do_nmi':
arch/i386/kernel/traps.c:752: undefined reference to 
`panic_on_unrecovered_nmi'
arch/i386/kernel/built-in.o(.text+0x3564):arch/i386/kernel/traps.c:712: 
undefined reference to `panic_on_unrecovered_nmi'


$ grep nmi arch/i386/kernel/Makefile
obj-$(CONFIG_X86_LOCAL_APIC)    += apic.o nmi.o

which I dont have enabled.

It looks to be due to changes in x86_64-mm-nmi-sysctl-cleanup.patch
