Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263916AbUCZDpm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 22:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbUCZDpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 22:45:42 -0500
Received: from codepoet.org ([166.70.99.138]:32236 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S263915AbUCZDpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 22:45:31 -0500
Date: Thu, 25 Mar 2004 20:45:04 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [sata] Promise PATA port on PDC2037x SATA
Message-ID: <20040326034504.GA2043@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <40638943.9010206@pobox.com> <20040326031619.GA1755@codepoet.org> <4063A64D.2000901@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4063A64D.2000901@pobox.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Mar 25, 2004 at 10:41:01PM -0500, Jeff Garzik wrote:
> Thanks for testing.
> 
> Is your PCI id listed in this function?
> 
> static int pdc_pata_possible(struct pci_dev *pdev)
> {
>         if (pdev->device == 0x3375)
>                 return 1;
>         return 0;
> }
> 
> If yes, hrm.  :)

$ lspci -v | grep -A9 Promise
02:0c.0 Unknown mass storage controller: Promise Technology, Inc.: Unknown device 3375 (rev 02)
        Subsystem: Promise Technology, Inc.: Unknown device 3375
        Flags: bus master, 66Mhz, medium devsel, latency 96, IRQ 20
        I/O ports at de80 [size=64]
        I/O ports at dfa0 [size=16]
        I/O ports at dc00 [size=128]
        Memory at feafe000 (32-bit, non-prefetchable) [size=4K]
        Memory at feac0000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at feab0000 [disabled] [size=16K]
        Capabilities: [60] Power Management version 2

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
