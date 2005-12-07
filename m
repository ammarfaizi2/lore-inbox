Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbVLGPhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbVLGPhh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 10:37:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVLGPhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 10:37:37 -0500
Received: from mail1.kontent.de ([81.88.34.36]:8665 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S1751138AbVLGPhg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 10:37:36 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [linux-usb-devel] Re: [PATCH 00/10] usb-serial: Switches from spin lock to atomic_t.
Date: Wed, 7 Dec 2005 16:37:39 +0100
User-Agent: KMail/1.8
Cc: Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net,
       Eduardo Pereira Habkost <ehabkost@mandriva.com>,
       Greg KH <gregkh@suse.de>,
       Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44L0.0512071000120.21143-100000@iolanthe.rowland.org> <1133968943.2869.26.camel@laptopd505.fenrus.org>
In-Reply-To: <1133968943.2869.26.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200512071637.40018.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 7. Dezember 2005 16:22 schrieb Arjan van de Ven:
> > On the other hand, Oliver needs to be careful about claiming too much.  In 
> > general atomic_t operations _are_ superior to the spinlock approach.
> 
> No they're not. Both are just about equally expensive cpu wise,
> sometimes the atomic_t ones are a bit more expensive (like on parisc
> architecture). But on x86 in either case it's a locked cycle, which is
> just expensive no matter which side you flip the coin...

You are refering to SMP, aren't you?

	Regards
		Oliver
