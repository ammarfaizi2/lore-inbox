Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbWIEOtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbWIEOtJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 10:49:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbWIEOtJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 10:49:09 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:46533 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S965066AbWIEOtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 10:49:08 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.4
Subject: Re: [PATCH] VIA IRQ quirk fixup only in XT_PIC mode Take 2
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Daniel Drake <dsd@gentoo.org>
Cc: bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Chris Wedgwood <cw@f00f.org>, greg@kroah.com, jeff@garzik.org,
       harmon@ksu.edu
In-Reply-To: <44FD7DAE.7030705@gentoo.org>
References: <1154091662.7200.9.camel@localhost.localdomain>
	 <44DE5A6F.50500@gentoo.org> <1156906638.3022.18.camel@localhost.portugal>
	 <44F50A0A.2040800@gentoo.org>
	 <1156937128.2624.6.camel@localhost.localdomain>
	 <44F5B933.2010608@gentoo.org>
	 <1157024002.2724.4.camel@localhost.localdomain>
	 <44FD7DAE.7030705@gentoo.org>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Sep 2006 15:49:14 +0100
Message-Id: <1157467754.30252.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 09:37 -0400, Daniel Drake wrote:
> Sergio Monteiro Basto wrote:
> > On Wed, 2006-08-30 at 12:13 -0400, Daniel Drake wrote:
> > 
> >>> about Linus suggestion : 
> >>> -   new_irq = dev->irq & 0xf;
> >>> +   new_irq = dev->irq;
> >>> +   if (!new_irq || new_irq >= 15)
> >>> +           return;
> >>>
> >>> no, we have problem with VIA SATA controllers which have irq lower
> than
> >>> 15 
> >> Any chance you can provide a link to this example so that we can 
> >> document the decision in the commit message?
> > 
> > http://lkml.org/lkml/2006/7/30/59
> 
> I'm confused. Heikki's report is about a sata_sil controller and he 
> didn't include any dmesg output so I don't know how you can conclude 
> that quirking an IRQ to something less than 15 was the fix...


> Also note that the fix was *not* quirking the device at all (your
> patch 
> ensured that the quirks didn't run because IO-APIC was enabled), this 
> hardly seems like an accurate way of arguing that quirks that change
> the 
> IRQ to something less than 15 are *required*... 

hum hum, "Vladimir B. Savkin" report on Asus A8V (kernel 2.6.14+) 
and Heikki Orsila talks about is ASUS K8V SE Deluxe on amd64 with SiI
3114 SATA controller. 
yes, when Heikki Orsila reports a positive test, I thought was talking
about "Vladimir B. Savkin" reports. 
Is petty that "Vladimir B. Savkin" don't response.
and Heikki Orsila don't show his dmesg :) 

thanks, 
--
Sérgio M. 

