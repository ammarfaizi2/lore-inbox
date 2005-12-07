Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbVLGPkX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbVLGPkX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 10:40:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbVLGPkX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 10:40:23 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37869 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751117AbVLGPkX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 10:40:23 -0500
Subject: Re: [linux-usb-devel] Re: [PATCH 00/10] usb-serial: Switches from
	spin lock to atomic_t.
From: Arjan van de Ven <arjan@infradead.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net,
       Eduardo Pereira Habkost <ehabkost@mandriva.com>,
       Greg KH <gregkh@suse.de>,
       Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200512071637.40018.oliver@neukum.org>
References: <Pine.LNX.4.44L0.0512071000120.21143-100000@iolanthe.rowland.org>
	 <1133968943.2869.26.camel@laptopd505.fenrus.org>
	 <200512071637.40018.oliver@neukum.org>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 16:40:14 +0100
Message-Id: <1133970015.2869.31.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 16:37 +0100, Oliver Neukum wrote:
> Am Mittwoch, 7. Dezember 2005 16:22 schrieb Arjan van de Ven:
> > > On the other hand, Oliver needs to be careful about claiming too much.  In 
> > > general atomic_t operations _are_ superior to the spinlock approach.
> > 
> > No they're not. Both are just about equally expensive cpu wise,
> > sometimes the atomic_t ones are a bit more expensive (like on parisc
> > architecture). But on x86 in either case it's a locked cycle, which is
> > just expensive no matter which side you flip the coin...
> 
> You are refering to SMP, aren't you?

yes.
on UP neither is a locked instruction ;)

