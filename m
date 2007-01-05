Return-Path: <linux-kernel-owner+w=401wt.eu-S965133AbXAEJQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965133AbXAEJQh (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 04:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965117AbXAEJQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 04:16:37 -0500
Received: from aa013msr.fastwebnet.it ([85.18.95.73]:47091 "EHLO
	aa013msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965112AbXAEJQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 04:16:36 -0500
Date: Fri, 5 Jan 2007 10:15:40 +0100
From: Mattia Dongili <malattia@linux.it>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Stelian Pop <stelian@popies.net>, Andrew Morton <akpm@osdl.org>,
       Len Brown <lenb@kernel.org>, Ismail Donmez <ismail@pardus.org.tr>,
       Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Message-ID: <20070105091539.GA13533@inferi.kami.home>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Stelian Pop <stelian@popies.net>, Andrew Morton <akpm@osdl.org>,
	Len Brown <lenb@kernel.org>, Ismail Donmez <ismail@pardus.org.tr>,
	Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net> <200701040024.29793.lenb@kernel.org> <1167905384.7763.36.camel@localhost.localdomain> <20070104191512.GC25619@inferi.kami.home> <20070104125107.b82db604.akpm@osdl.org> <1167953784.4901.5.camel@localhost.localdomain> <Pine.LNX.4.61.0701050110170.8556@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0701050110170.8556@yvahk01.tjqt.qr>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.20-rc2-mm1-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2007 at 01:11:16AM +0100, Jan Engelhardt wrote:
> 
> On Jan 5 2007 00:36, Stelian Pop wrote:
> >@@ -61,6 +61,7 @@ static struct acpi_driver sony_acpi_driv
> > 
> > static acpi_handle sony_acpi_handle;
> > static struct proc_dir_entry *sony_acpi_dir;
> >+static struct acpi_device *sony_acpi_acpi_device = NULL;
> 
> acpi_acpi?
> 
> >@@ -310,7 +315,7 @@ static int sony_acpi_add(struct acpi_dev
> > 		    		 item->acpiset, &handle)))
> > 		    	continue;
> > 
> >-		item->proc = create_proc_entry(item->name, 0600,
> >+		item->proc = create_proc_entry(item->name, 0666,
> > 					       acpi_device_dir(device));
> > 		if (!item->proc) {
> > 			printk(LOG_PFX "unable to create proc entry\n");
> 
> Is this safe? I would not want normal users to poke on that.

Hmmm, seconded. It also seems quite a gratuitous change and I have a
different patch that takes care of permissions and the /proc stuff is
going away in any case.

-- 
mattia
:wq!
