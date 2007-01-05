Return-Path: <linux-kernel-owner+w=401wt.eu-S965113AbXAEAVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965113AbXAEAVl (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 19:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965104AbXAEAVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 19:21:41 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:57774 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965103AbXAEAVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 19:21:40 -0500
Date: Fri, 5 Jan 2007 01:11:16 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Stelian Pop <stelian@popies.net>
cc: Andrew Morton <akpm@osdl.org>, Mattia Dongili <malattia@linux.it>,
       Len Brown <lenb@kernel.org>, Ismail Donmez <ismail@pardus.org.tr>,
       Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
In-Reply-To: <1167953784.4901.5.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0701050110170.8556@yvahk01.tjqt.qr>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net> 
 <200701040024.29793.lenb@kernel.org>  <1167905384.7763.36.camel@localhost.localdomain>
  <20070104191512.GC25619@inferi.kami.home>  <20070104125107.b82db604.akpm@osdl.org>
 <1167953784.4901.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 5 2007 00:36, Stelian Pop wrote:
>@@ -61,6 +61,7 @@ static struct acpi_driver sony_acpi_driv
> 
> static acpi_handle sony_acpi_handle;
> static struct proc_dir_entry *sony_acpi_dir;
>+static struct acpi_device *sony_acpi_acpi_device = NULL;

acpi_acpi?

>@@ -310,7 +315,7 @@ static int sony_acpi_add(struct acpi_dev
> 		    		 item->acpiset, &handle)))
> 		    	continue;
> 
>-		item->proc = create_proc_entry(item->name, 0600,
>+		item->proc = create_proc_entry(item->name, 0666,
> 					       acpi_device_dir(device));
> 		if (!item->proc) {
> 			printk(LOG_PFX "unable to create proc entry\n");

Is this safe? I would not want normal users to poke on that.


	-`J'
--
Himself owner of a VAIO U3.
