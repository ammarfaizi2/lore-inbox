Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbVBPNqQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbVBPNqQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 08:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbVBPNqQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 08:46:16 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:62852 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262014AbVBPNqO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 08:46:14 -0500
Subject: Re: avoiding pci_disable_device()...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Arjan van de Ven <arjan@infradead.org>,
       Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <s5hhdkcbv94.wl@alsa2.suse.de>
References: <4210021F.7060401@pobox.com> <20050214190619.GA9241@kroah.com>
	 <4211013E.6@pobox.com> <1108411352.5994.27.camel@localhost.localdomain>
	 <42115906.3040003@pobox.com>  <s5hhdkcbv94.wl@alsa2.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1108561461.8303.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 16 Feb 2005 13:44:26 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> OTOH this will introduce more buglets to broken drivers which don't
> call pci_disable_device() properly.  Consequently, the ad hoc fix to
> each driver like Jeff's patch might be most practical...

This is true but it does provide the mechanism to fix such devices. It
also fails safe because a driver that fails to disable leaves the device
always enabled.

With the ability to mark the specific awkward cases as "enabled on boot"
we can remove some of the horrible special case issues like IDE
controllers using BARs of the northbridge.

Alan

