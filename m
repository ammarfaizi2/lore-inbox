Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945906AbWJaTvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945906AbWJaTvE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 14:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945907AbWJaTvD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 14:51:03 -0500
Received: from orion2.pixelized.ch ([195.190.190.13]:43906 "EHLO
	mail.pixelized.ch") by vger.kernel.org with ESMTP id S1945906AbWJaTvB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 14:51:01 -0500
Message-ID: <4547A916.2070709@cateee.net>
Date: Tue, 31 Oct 2006 20:50:46 +0100
From: Giacomo Catenazzi <cate@cateee.net>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Panic with 2.6.19-rc3-ga7aacdf9: Invalid opcode at acpi_os_read_pci_configuration
References: <45470810.4040905@cateee.net>	<20061031021810.dd48361f.akpm@osdl.org>	<4547257B.7090101@cateee.net> <20061031024150.7c4a452f.akpm@osdl.org>
In-Reply-To: <20061031024150.7c4a452f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 31 Oct 2006 11:29:15 +0100
> "Giacomo A. Catenazzi" <cate@cateee.net> wrote:
> 
>>> And acpi keeled over as a result.
>>>
>>> Do you have CONFIG_PCI_MULTITHREAD_PROBE=y?   If so, try disabling it.
>> No:
>> # CONFIG_PCI_MULTITHREAD_PROBE is not set
>>
>> The config is in:
>> http://www.cateee.net/kernel/config
> 
> Your PCI access mode is set to MMCONFIG.  Try setting it to "any" (under the
> bus options menu).

Ok. It solves the problem. I really don't understand why it
was changed. I remember that I looked for the documentation, so
probably I pressed the wrong key.
Sorry for the wrong bug report.

thanks
	cate

