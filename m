Return-Path: <linux-kernel-owner+w=401wt.eu-S1751837AbWLNKZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbWLNKZS (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 05:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbWLNKZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 05:25:18 -0500
Received: from www.osadl.org ([213.239.205.134]:51810 "EHLO mail.tglx.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751837AbWLNKZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 05:25:17 -0500
From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Userspace I/O driver core
Date: Thu, 14 Dec 2006 11:25:14 +0100
User-Agent: KMail/1.9.5
References: <20061214010608.GA13229@kroah.com> <45811D0F.2070705@argo.co.il>
In-Reply-To: <45811D0F.2070705@argo.co.il>
Organization: Linutronix
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612141125.14777.hjk@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 14. Dezember 2006 10:44 schrieb Avi Kivity:

> 
> I understand one still has to write a kernel driver to shut up the irq.  
> How about writing a small bytecode interpreter to make event than 
> unnecessary?
> 
> The userspace driver would register a couple of bytecode programs: 
> is_interrupt_pending() and disable_interrupt(), which the uio framework 
> would call when the interrupt fires.
> 
> The bytecode could reuse net/core/filter.c, with the packet replaced by 
> the mmio or ioregion, or use something new.
> 

I think this would be overkill. The kernel module you have to write
is _really_ very simple. And it has to be written only once, so even
a manufacturer who employs no experienced kernel developers can
easily outsource that task.

Hans

