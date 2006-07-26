Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751628AbWGZOG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbWGZOG1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 10:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbWGZOG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 10:06:27 -0400
Received: from relay6.ptmail.sapo.pt ([212.55.154.26]:57569 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1751622AbWGZOG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 10:06:27 -0400
X-Spam-Flag: NO
X-Spam-Hit: BAYES_00
X-AntiVirus: PTMail-AV 0.3-0.88.3
Subject: Re: [PATCH] Add SATA device to VIA IRQ quirk fixup list
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Daniel Drake <dsd@gentoo.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Chris Wedgwood <cw@f00f.org>, greg@kroah.com, jeff@garzik.org,
       harmon@ksu.edu, linux-kernel@vger.kernel.org
In-Reply-To: <44C77544.1050205@gentoo.org>
References: <20060714095233.5678A8B6253@zog.reactivated.net>
	 <44B77B1A.6060502@garzik.org> <44B78294.1070308@gentoo.org>
	 <44B78538.6030909@garzik.org> <20060714074305.1248b98e.akpm@osdl.org>
	 <44BA48A0.2060008@gentoo.org> <20060716183126.GB4483@kroah.com>
	 <20060717003418.GA27166@tuatara.stupidest.org>
	 <20060724214046.1c1b646e.akpm@osdl.org>
	 <1153874577.7559.36.camel@localhost>
	 <1153917954.29975.22.camel@bastov.localdomain>
	 <44C77544.1050205@gentoo.org>
Content-Type: text/plain; charset=utf-8
Date: Wed, 26 Jul 2006 15:06:14 +0100
Message-Id: <1153922774.4486.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-07-26 at 14:59 +0100, Daniel Drake wrote:
> Sergio Monteiro Basto wrote:
> > I want put here something like:  if ( dev->irq != XT-PIC) return and
> > don't quirk this dev.
> 
> I can't explain why, but this is not sufficient. Gentoo now have 2 
> completely separate bug reports where the quirk is *only* needed when 
> ACPI/APIC are enabled.
> 

No, Quirks are only need when interrupts are in XT-PIC. (is my bet).
When APIC and ACPI is enabled (and working) we don't need quirks.

Someone said on XT-PIC VIA system, don't need, to boot, quirks when ACPI
is disabled, but this statement don't prove that the quirk aren't need
it . 

--
Sérgio M. B. 


> http://bugs.gentoo.org/138036
> http://bugs.gentoo.org/141082
> 
> I'm not disputing that there are other systems where the opposite is 
> true, but at least with our current level of understanding we cannot 
> apply the quirk on an irq-type basis.
> 
> Daniel
> 

