Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbVGFLEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbVGFLEE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 07:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbVGFLED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 07:04:03 -0400
Received: from [203.171.93.254] ([203.171.93.254]:13726 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262072AbVGFIe3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 04:34:29 -0400
Subject: Re: [PATCH] [4/48] Suspend2 2.1.9.8 for 2.6.12:
	302-init-hooks.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Li Shaohua <shaohua.li@intel.com>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1120639125.2908.5.camel@linux-hp.sh.intel.com>
References: <11206164392@foobar.com>
	 <1120639125.2908.5.camel@linux-hp.sh.intel.com>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120638954.4860.49.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 06 Jul 2005 18:35:55 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-07-06 at 18:38, Shaohua Li wrote:
> On Wed, 2005-07-06 at 12:20 +1000, Nigel Cunningham wrote:
> > diff -ruNp 350-workthreads.patch-old/drivers/acpi/osl.c 350-workthreads.patch-new/drivers/acpi/osl.c
> > --- 350-workthreads.patch-old/drivers/acpi/osl.c	2005-06-20 11:46:50.000000000 +1000
> > +++ 350-workthreads.patch-new/drivers/acpi/osl.c	2005-07-04 23:14:18.000000000 +1000
> > @@ -95,7 +95,7 @@ acpi_os_initialize1(void)
> >  		return AE_NULL_ENTRY;
> >  	}
> >  #endif
> > -	kacpid_wq = create_singlethread_workqueue("kacpid");
> > +	kacpid_wq = create_singlethread_workqueue("kacpid", PF_NOFREEZE);
> >  	BUG_ON(!kacpid_wq);
> I'm not sure but kacpid can run any kind of code (depends on BIOS, it
> might touch some devices), is this safe?

If it's not, then we definitely want this patch as all workqueues are
NOFREEZE at the moment.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

