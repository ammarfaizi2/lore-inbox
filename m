Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265641AbTFNIGk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 04:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265642AbTFNIGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 04:06:40 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:59064
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265641AbTFNIGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 04:06:37 -0400
Subject: Re: 2.4.21-rc7 hang on boot after spurious 8259A interrupt: IRQ15.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: Vojtech Pavlik <vojtech@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200306141124.09882.mflt1@micrologica.com.hk>
References: <200306130958.39707.mflt1@micrologica.com.hk>
	 <20030613214832.A6366@ucw.cz> <200306141124.09882.mflt1@micrologica.com.hk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055578663.7651.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jun 2003 09:17:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The system executes a regular boot from _reset_ at this stage.
> swsusp takes over once the kernel is up and restores the
> suspended kernel
> Could it be that the kernel does not handle a spurious int at 
> this early stage in the boot process ?

It may also be BIOS SMI handling or reset handling problems as a
similar case a vendor investigated showed to be. The first thing is
to make life easier for the BIOS - make sure your kernel doesnt have
APIC support included

