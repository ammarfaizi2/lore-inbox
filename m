Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261782AbTJHVTN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 17:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbTJHVTN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 17:19:13 -0400
Received: from maxlb1ip.uk2net.com ([213.239.57.81]:18842 "EHLO
	maxio7.uk2net.com") by vger.kernel.org with ESMTP id S261782AbTJHVTK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 17:19:10 -0400
Message-ID: <57145.212.113.164.100.1065647937.squirrel@maxproxy3.uk2net.com>
In-Reply-To: <20031008200420.GA23545@redhat.com>
References: <42450.212.113.164.100.1065637962.squirrel@maxproxy1.uk2net.com>
    <20031008200420.GA23545@redhat.com>
Date: Wed, 8 Oct 2003 22:18:57 +0100 (BST)
From: "Nuno Monteiro" <nmonteiro@uk2.net>
To: "Dave Jones" <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
X-Priority: 3
Importance: Normal
X-SA-Exim-Mail-From: nmonteiro@uk2.net
Subject: Re: linking problem with 2.6.0-test6-bk10
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 3.0 (built Tue May 27 21:41:10 CEST 2003)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Oct 08, 2003 at 07:32:42PM +0100, Nuno Monteiro wrote:
>
> Try this.
>
> 		Dave


Hi Dave,

Thanks for the input, but still no joy. I applied that to a pristine
-test7 tree, same error as before (altough the address is a little
different: 2ebd, now 2eb6).

        ld -m elf_i386  -T arch/i386/kernel/vmlinux.lds.s
arch/i386/kernel/head.o arch/i386/kernel/init_task.o  
init/built-in.o --start-group  usr/built-in.o 
arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o 
arch/i386/mach-default/built-in.o  kernel/built-in.o 
mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o 
crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  lib/built-in.o 
arch/i386/lib/built-in.o  drivers/built-in.o  sound/built-in.o 
arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
arch/i386/kernel/built-in.o(.init.text+0x2eb6): In function
`centaur_mcr_insert':
: undefined reference to `mtrr_centaur_report_mcr'
make: *** [vmlinux] Error 1
nuno@hobbes:/usr/local/src/linux-2.6.0-test7$


Regards,

Nuno

