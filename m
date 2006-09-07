Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbWIGAWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbWIGAWv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 20:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965285AbWIGAWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 20:22:51 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:19179 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S964894AbWIGAWu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 20:22:50 -0400
Subject: Re: 2.6.18-rc5-mm1 module build symbol issues -- mkinitrd
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: lkml <linux-kernel@vger.kernel.org>
Cc: andrew <akpm@osdl.org>
In-Reply-To: <1157576720.5713.37.camel@keithlap>
References: <1157576720.5713.37.camel@keithlap>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Wed, 06 Sep 2006 17:22:46 -0700
Message-Id: <1157588567.5713.42.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-06 at 14:05 -0700, keith mannthey wrote:
> Hello,
>   Some things have changed between rc5-mm1 and rc4-mm3.  During my build
> process I pickup the following errors when making the initrd. I don't
> see any errors during modules_install. 
> 
> 
> WARNING: /var/tmp/mkinitramfs.N19592/mnt/lib/modules/2.6.18-rc5-mm1-
> smp/kernel/drivers/acpi/processor.ko needs unknown symbol
> register_latency_notifier
> WARNING: /var/tmp/mkinitramfs.N19592/mnt/lib/modules/2.6.18-rc5-mm1-
> smp/kernel/drivers/acpi/processor.ko needs unknown symbol
> system_latency_constraint
> WARNING: /var/tmp/mkinitramfs.N19592/mnt/lib/modules/2.6.18-rc5-mm1-
> smp/kernel/drivers/acpi/processor.ko needs unknown symbol
> unregister_latency_notifier
> WARNING: /var/tmp/mkinitramfs.N19592/mnt/lib/modules/2.6.18-rc5-mm1-
> smp/kernel/drivers/scsi/scsi_mod.ko needs unknown symbol blk_free_tags
> 
> 
> My config build all of SCSI as modules and loads them into an initrd.
> As I build things into the kernel the errors go away but if I build say
> scsi support into the kernel all the symbols from host.c start not
> linking (lots and lots of unknown symbols)  
> 
> Maybe these are just warning from my mkinird scrips (SLES based) but I
> wasn't seeing these until rc5-mm1.  The symbols in question seem to be
> exported correctly so I am not sure what the deal is. 
> 
> Has some linker / module script been changed or is my mkinitrd script
> off in la-la land? 

Well I see this issue with rc5 and rc6 as well so it is some mainline
change.  I booted an rc6 kernel with the error messages and it worked
booted so it mush be a safe to ignore warning at this point.  It just
seems weird that the behavior changed between rc4 and tc5. 

Thanks,
  Keith 

