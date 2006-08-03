Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751368AbWHCUty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWHCUty (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 16:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWHCUty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 16:49:54 -0400
Received: from mga01.intel.com ([192.55.52.88]:12822 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751362AbWHCUtw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 16:49:52 -0400
X-IronPort-AV: i="4.07,209,1151910000"; 
   d="scan'208"; a="110288485:sNHT2200630607"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Options depending on STANDALONE
Date: Thu, 3 Aug 2006 16:49:08 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB601260CC7@hdsmsx411.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Options depending on STANDALONE
Thread-Index: Aca3PF3j0IrWW1R1QHyr4wSxnTbBFgAACb4A
From: "Brown, Len" <len.brown@intel.com>
To: "Greg KH" <greg@kroah.com>, "Adrian Bunk" <bunk@stusta.de>
Cc: "Dave Jones" <davej@redhat.com>, "Zachary Amsden" <zach@vmware.com>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Rusty Russell" <rusty@rustcorp.com.au>, "Jack Lo" <jlo@vmware.com>,
       <v4l-dvb-maintainer@linuxtv.org>, <linux-acpi@vger.kernel.org>
X-OriginalArrivalTime: 03 Aug 2006 20:49:10.0969 (UTC) FILETIME=[45920290:01C6B73E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Thu, Aug 03, 2006 at 10:25:43PM +0200, Adrian Bunk wrote:
>> ACPI_CUSTOM_DSDT seems to be the most interesting case.
>> It's anyway not usable for distribution kernels, and AFAIR the ACPI 
>> people prefer to get the kernel working with all original DSDTs
>> (which usually work with at least one other OS) than letting 
>> the people workaround the problem by using a custom DSDT.
>
>Not true at all.  For SuSE kernels, we have a patch that lets people
>load a new DSDT from initramfs due to broken machines requiring a
>replacement in order to work properly.

CONFIG_ACPI_CUSTOM_DSDT allows hackers to debug their system
by building a modified DSDT into the kernel to over-ride what
came with the system.  It would make no sense for a distro
to use it, unless the distro were shipping only on 1 model machine.
This technique is necessary for debugging, but makes no
sense for production.

The initramfs method shipped by SuSE is more flexible, allowing
the hacker to stick the DSDT image in the initrd and use it
without re-compiling the kernel.

I have refused to accept the initrd patch into Linux many times,
and always will.

I've advised SuSE many times that they should not be shipping it,
as it means that their supported OS is running on modified firmware --
which, by definition, they can not support.  Indeed, one could view
this method as couter-productive to the evolution of Linux --
since it is our stated goal to run on the same machines that Windows
runs on -- without requiring customers to modify those machines
to run Linux.

-Len
