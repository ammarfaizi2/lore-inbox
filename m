Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422863AbWJaK3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422863AbWJaK3Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 05:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422866AbWJaK3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 05:29:25 -0500
Received: from orion2.pixelized.ch ([195.190.190.13]:25540 "EHLO
	mail.pixelized.ch") by vger.kernel.org with ESMTP id S1422863AbWJaK3Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 05:29:24 -0500
Message-ID: <4547257B.7090101@cateee.net>
Date: Tue, 31 Oct 2006 11:29:15 +0100
From: "Giacomo A. Catenazzi" <cate@cateee.net>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Panic with 2.6.19-rc3-ga7aacdf9: Invalid opcode at acpi_os_read_pci_configuration
References: <45470810.4040905@cateee.net> <20061031021810.dd48361f.akpm@osdl.org>
In-Reply-To: <20061031021810.dd48361f.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Tue, 31 Oct 2006 09:23:44 +0100
> Giacomo Catenazzi <cate@cateee.net> wrote:
> 
>> Since few days I have this bug (not sure if it
>> caused by changed configuration or if it is a regretion).
>> The fololowing trace is from last git.
>>
>> ...
>>
>>
>> [    0.012497] Brought up 4 CPUs
>> [    0.174941] migration_cost=19,713
>> [    0.215588] NET: Registered protocol family 16
>> [    0.268807] ACPI: bus type pci registered
>> [    0.316660] PCI: Fatal: No config space access function found
> 
> That looks pretty bad.
> 
>> [    0.385262] Setting up standard PCI resources
>> [    0.452566] ACPI: Access to PCI configuration space unavailable
>> [    0.527856] ACPI: Interpreter enabled
>> [    0.571564] ACPI: Using IOAPIC for interrupt routing
>> [    0.631370] ACPI: PCI Root Bridge [PCI0] (0000:00)
>> [    0.690684] ------------[ cut here ]------------
>> [    0.745825] kernel BUG at drivers/acpi/osl.c:461!
> 
> And acpi keeled over as a result.
> 
> Do you have CONFIG_PCI_MULTITHREAD_PROBE=y?   If so, try disabling it.

No:
# CONFIG_PCI_MULTITHREAD_PROBE is not set

The config is in:
http://www.cateee.net/kernel/config

and for reference hte kernel log:
http://www.cateee.net/kernel/kern

ciao
	cate
