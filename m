Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266548AbUHBPQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266548AbUHBPQd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 11:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266554AbUHBPQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 11:16:32 -0400
Received: from the-village.bc.nu ([81.2.110.252]:22451 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266548AbUHBPQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 11:16:31 -0400
Subject: Re: finding out the boot cpu number from userspace
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040802121635.GE14477@devserv.devel.redhat.com>
References: <20040802121635.GE14477@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091456034.437.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 02 Aug 2004 15:13:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-02 at 13:16, Arjan van de Ven wrote:
> Hi,
> 
> assuming cpu 0 is the boot cpu sounds fragile/incorrect, but for irqbalanced
> I'd like to find out which cpu is the boot cpu, is there a good way of doing
> so ?
> 
> The reason for needing this is that some firmware only likes running on the
> boot cpu so I need to bind firmware-related irq's to that cpu ideally.

Grab the physical CPU id during boot up and stick it in the
/proc/cpuinfo as another information line "Boot device: Yes/no"

Just don't use "Processor" in the string or some glibc's start getting
strange ideas about the CPU count.

