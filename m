Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262507AbVBEMn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbVBEMn5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 07:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263363AbVBEMn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 07:43:56 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:25256 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S264669AbVBEMnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 07:43:42 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.11-rc3-mm1: kobject_register fails for processor on Athlon64
Date: Sat, 5 Feb 2005 13:44:21 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <20050204103350.241a907a.akpm@osdl.org>
In-Reply-To: <20050204103350.241a907a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502051344.21996.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 4 of February 2005 19:33, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc3/2.6.11-rc3-mm1/

This occurs on my box (Athlon64-based) if "processor" is directly compiled into
the kernel:

ACPI: Lid Switch [LID]
ACPI: Fan [FN00] (off)
kobject_register failed for processor (-17)

Call Trace:<ffffffff80273e16>{kobject_register+70} <ffffffff80161c3c>{sys_init_module+5980}
       <ffffffff8010f4bd>{error_exit+0} <ffffffff802ce13d>{acpi_bus_register_driver+0}
       <ffffffff8016de90>{file_read_actor+0} <ffffffff8016fa77>{__generic_file_aio_read+423}
       <ffffffff8016fc91>{generic_file_aio_read+49} <ffffffff8019a29d>{do_sync_read+173}
       <ffffffff801226bc>{do_page_fault+1100} <ffffffff80159c70>{autoremove_wake_function+0}
       <ffffffff8019afb6>{vfs_read+230} <ffffffff8019b143>{sys_read+83}
       <ffffffff8010ebf2>{system_call+126}
kobject_register failed for processor (-17)

Call Trace:<ffffffff80273e16>{kobject_register+70} <ffffffff80161c3c>{sys_init_module+5980}
       <ffffffff8010f4bd>{error_exit+0} <ffffffff802ce13d>{acpi_bus_register_driver+0}
       <ffffffff8016de90>{file_read_actor+0} <ffffffff8016fa77>{__generic_file_aio_read+423}
       <ffffffff8016fc91>{generic_file_aio_read+49} <ffffffff8019a29d>{do_sync_read+173}
       <ffffffff801226bc>{do_page_fault+1100} <ffffffff80159c70>{autoremove_wake_function+0}
       <ffffffff8019afb6>{vfs_read+230} <ffffffff8019b143>{sys_read+83}
       <ffffffff8010ebf2>{system_call+126}

It does not happen if it's a module.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
