Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265061AbTGGQqR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 12:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265076AbTGGQqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 12:46:17 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:52922 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S265061AbTGGQqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 12:46:17 -0400
Date: Mon, 7 Jul 2003 19:00:47 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-pre3-ac1
Message-ID: <20030707170047.GC13102@louise.pinerecords.com>
References: <200307071634.h67GYZo06861@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307071634.h67GYZo06861@devserv.devel.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [alan@redhat.com]
> 
> Linux 2.4.22-pre3-ac1

arch/i386/kernel/kernel.o: In function `setup_ioapic_ids_from_mpc':
arch/i386/kernel/kernel.o(.text.init+0x92b0): undefined reference to `xapic_support'
arch/i386/kernel/kernel.o(.text.init+0x94e5): undefined reference to `xapic_support'
make: *** [vmlinux] Error 1

$ find . -type f|xargs grep apic_sup
./arch/i386/kernel/io_apic.c:extern unsigned int xapic_support;
./arch/i386/kernel/io_apic.c:           if (!xapic_support && 
./arch/i386/kernel/io_apic.c:           if (!xapic_support &&
Binary file ./arch/i386/kernel/io_apic.o matches
Binary file ./arch/i386/kernel/kernel.o matches
$

ooops
