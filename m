Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751563AbWHaLd3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbWHaLd3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 07:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751569AbWHaLd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 07:33:29 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:43746 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S1751560AbWHaLd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 07:33:28 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.4
Subject: Re: [PATCH] VIA IRQ quirk fixup only in XT_PIC mode Take 2
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Daniel Drake <dsd@gentoo.org>
Cc: bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Chris Wedgwood <cw@f00f.org>, greg@kroah.com, jeff@garzik.org,
       harmon@ksu.edu
In-Reply-To: <44F5B933.2010608@gentoo.org>
References: <1154091662.7200.9.camel@localhost.localdomain>
	 <44DE5A6F.50500@gentoo.org> <1156906638.3022.18.camel@localhost.portugal>
	 <44F50A0A.2040800@gentoo.org>
	 <1156937128.2624.6.camel@localhost.localdomain>
	 <44F5B933.2010608@gentoo.org>
Content-Type: text/plain; charset=utf-8
Date: Thu, 31 Aug 2006 12:33:22 +0100
Message-Id: <1157024002.2724.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-30 at 12:13 -0400, Daniel Drake wrote:

> > about Linus suggestion : 
> > -	new_irq = dev->irq & 0xf;
> > +	new_irq = dev->irq;
> > +	if (!new_irq || new_irq >= 15)
> > +		return;
> > 
> > no, we have problem with VIA SATA controllers which have irq lower than
> > 15 
> 
> Any chance you can provide a link to this example so that we can 
> document the decision in the commit message?

http://lkml.org/lkml/2006/7/30/59



Thanks,
--
Sérgio M. B.

