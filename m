Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751563AbWIYWjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbWIYWjh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 18:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbWIYWjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 18:39:37 -0400
Received: from smtp-out.google.com ([216.239.45.12]:5432 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751562AbWIYWjg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 18:39:36 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:
	x-accept-language:mime-version:to:cc:subject:content-type:content-transfer-encoding;
	b=ClGRZCfjg9PiqSImYbotQ72ybGShDKEBkLdnKNLC3aRYgtiDOUqkGvKGV+9s20T/V
	nzVdMYPztroX4sJKDEHhQ==
Message-ID: <45185A93.7020105@google.com>
Date: Mon, 25 Sep 2006 15:39:15 -0700
From: Martin Bligh <mbligh@google.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051011)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
Subject: 2.6.18-mm1 compile failure on x86_64
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://test.kernel.org/abat/49037/debug/test.log.0	

   AS      arch/x86_64/boot/bootsect.o
   LD      arch/x86_64/boot/bootsect
   AS      arch/x86_64/boot/setup.o
   LD      arch/x86_64/boot/setup
   AS      arch/x86_64/boot/compressed/head.o
   CC      arch/x86_64/boot/compressed/misc.o
   OBJCOPY arch/x86_64/boot/compressed/vmlinux.bin
BFD: Warning: Writing section `.data.percpu' to huge (ie negative) file 
offset 0x804700c0.
/usr/local/autobench/sources/x86_64-cross/gcc-3.4.0-glibc-2.3.2/bin/x86_64-unknown-linux-gnu-objcopy: 
arch/x86_64/boot/compressed/vmlinux.bin: File truncated
make[2]: *** [arch/x86_64/boot/compressed/vmlinux.bin] Error 1
make[1]: *** [arch/x86_64/boot/compressed/vmlinux] Error 2
make: *** [bzImage] Error 2
09/25/06-09:13:48 Build the kernel. Failed rc = 2
09/25/06-09:13:49 build: kernel build Failed rc = 1

Wierd. Same box compiled 2.6.18 fine.

M.
