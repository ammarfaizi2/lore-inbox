Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbTHYWxi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 18:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262372AbTHYWxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 18:53:38 -0400
Received: from havoc.gtf.org ([63.247.75.124]:7119 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262364AbTHYWxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 18:53:32 -0400
Date: Mon, 25 Aug 2003 18:53:30 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: [bk patch] add hw_random driver
Message-ID: <20030825225330.GA9559@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Marcelo, please do a

	bk pull bk://kernel.bkbits.net/jgarzik/hwrandom-2.4

I have sent the patch in a separate email, privately to you, for review.

Others may download the patch from

ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.4/2.4.22-hwrandom1.patch.bz2

This will update the following files:

 Documentation/Configure.help  |   15 
 Documentation/hw_random.txt   |  138 +++++++++
 arch/i386/kernel/head.S       |    4 
 arch/i386/kernel/setup.c      |   78 +++--
 drivers/char/Config.in        |    4 
 drivers/char/Makefile         |    1 
 drivers/char/hw_random.c      |  631 ++++++++++++++++++++++++++++++++++++++++++
 include/asm-i386/cpufeature.h |   19 +
 include/asm-i386/msr.h        |    1 
 9 files changed, 864 insertions(+), 27 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/08/25 1.1069)
   [ia32] mention that X86_VENDOR_ID is tied to NCAPINTS,
   in a comment in arch/i386/kernel/head.S.

<mikpe@csd.uu.se> (03/08/09 1.1068)
   [ia32] adjust X86_VENDOR_ID offset in head.S, due to new NCAPINTS

<jgarzik@redhat.com> (03/08/07 1.1067)
   [hw_random] add combined Intel+AMD+VIA h/w RNG driver

<jgarzik@redhat.com> (03/08/07 1.1066)
   [ia32] Via, Intel cpu capabilities update
   
   * /proc/cpuinfo support for Intel Prescott New Instructions (PNI)
   * /proc/cpuinfo support for Centuar Extended Feature Flags
     (including "xstore", Via RNG support)
   * at boot time, input x86 capability data for the two featuresets
   * sync include/asm-i386/cpufeature.h definitions with 2.6.x

