Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbWIFVFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbWIFVFX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 17:05:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751464AbWIFVFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 17:05:23 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:62369 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751459AbWIFVFW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 17:05:22 -0400
Subject: 2.6.18-rc5-mm1 module build symbol issues -- mkinitrd
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: andrew <akpm@osdl.org>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Wed, 06 Sep 2006 14:05:19 -0700
Message-Id: <1157576720.5713.37.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
  Some things have changed between rc5-mm1 and rc4-mm3.  During my build
process I pickup the following errors when making the initrd. I don't
see any errors during modules_install. 


WARNING: /var/tmp/mkinitramfs.N19592/mnt/lib/modules/2.6.18-rc5-mm1-
smp/kernel/drivers/acpi/processor.ko needs unknown symbol
register_latency_notifier
WARNING: /var/tmp/mkinitramfs.N19592/mnt/lib/modules/2.6.18-rc5-mm1-
smp/kernel/drivers/acpi/processor.ko needs unknown symbol
system_latency_constraint
WARNING: /var/tmp/mkinitramfs.N19592/mnt/lib/modules/2.6.18-rc5-mm1-
smp/kernel/drivers/acpi/processor.ko needs unknown symbol
unregister_latency_notifier
WARNING: /var/tmp/mkinitramfs.N19592/mnt/lib/modules/2.6.18-rc5-mm1-
smp/kernel/drivers/scsi/scsi_mod.ko needs unknown symbol blk_free_tags


My config build all of SCSI as modules and loads them into an initrd.
As I build things into the kernel the errors go away but if I build say
scsi support into the kernel all the symbols from host.c start not
linking (lots and lots of unknown symbols)  

Maybe these are just warning from my mkinird scrips (SLES based) but I
wasn't seeing these until rc5-mm1.  The symbols in question seem to be
exported correctly so I am not sure what the deal is. 

Has some linker / module script been changed or is my mkinitrd script
off in la-la land? 

Thanks,
  Keith  

