Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263518AbTDIPAX (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 11:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263519AbTDIPAX (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 11:00:23 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10908
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263518AbTDIPAW (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 11:00:22 -0400
Subject: Re: 2.4.21pre6 (__ide_dma_test_irq) called while not waiting
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200304091038_MC3-1-33B3-570A@compuserve.com>
References: <200304091038_MC3-1-33B3-570A@compuserve.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049897143.10380.22.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Apr 2003 15:05:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-09 at 15:35, Chuck Ebbert wrote:
>  Even when /proc/interrupts says XT-PIC?  I have uniprocessor
> MPS 1.4 machines and build IO-APIC kernels for them because
> I thought it was safer to share interrupts that way.  The
> four extra IRQ lines help, too. :)

IDE is a bit more complex than basic stuff but

PCI lines to the PIC are level triggered
Legacy IRQ for host IDE controllers may be edge triggered but
if so won't be shared

