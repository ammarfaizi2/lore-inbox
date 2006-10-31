Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752053AbWJaKl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbWJaKl6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 05:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbWJaKl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 05:41:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63934 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423083AbWJaKl5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 05:41:57 -0500
Date: Tue, 31 Oct 2006 02:41:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Giacomo A. Catenazzi" <cate@cateee.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Panic with 2.6.19-rc3-ga7aacdf9: Invalid opcode at
 acpi_os_read_pci_configuration
Message-Id: <20061031024150.7c4a452f.akpm@osdl.org>
In-Reply-To: <4547257B.7090101@cateee.net>
References: <45470810.4040905@cateee.net>
	<20061031021810.dd48361f.akpm@osdl.org>
	<4547257B.7090101@cateee.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2006 11:29:15 +0100
"Giacomo A. Catenazzi" <cate@cateee.net> wrote:

> > And acpi keeled over as a result.
> > 
> > Do you have CONFIG_PCI_MULTITHREAD_PROBE=y?   If so, try disabling it.
> 
> No:
> # CONFIG_PCI_MULTITHREAD_PROBE is not set
> 
> The config is in:
> http://www.cateee.net/kernel/config

Your PCI access mode is set to MMCONFIG.  Try setting it to "any" (under the
bus options menu).

