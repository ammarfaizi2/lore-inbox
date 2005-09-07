Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751240AbVIGQgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751240AbVIGQgx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 12:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVIGQgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 12:36:53 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:14471 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751240AbVIGQgw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 12:36:52 -0400
Subject: Re: 'virtual HW' into kernel (SystemC)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: =?ISO-8859-1?Q?M=E0rius_Mont=F3n?= <Marius.Monton@uab.es>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <431EC16B.2040604@uab.es>
References: <431EC16B.2040604@uab.es>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Wed, 07 Sep 2005 18:01:29 +0100
Message-Id: <1126112489.8928.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-09-07 at 12:31 +0200, Màrius Montón wrote:
> At this point, we plan to develop a pci device driver to act as a bridge
> between kernel PCI subsystem and SystemC simulator (in user space).

The first thing that would worry me about such an architecture would be
deadlocks between user space and kernel PCI accesses trapped under
simulation.

If you take a look at Xen or qemu both would give you a way to run the
virtualised simulated device in Linux user space on a sane complete
Linux environment while running a seperate copy of Linux experiencing
the simulated device.

Xen is fast - very fast, qemu is somewhat slower but because it is a JIT
can do accurate tracing and has a lovely well designed API for adding
virtualised drivers, plus nice examples like video cards and a virtual
NE2000.

Alan

