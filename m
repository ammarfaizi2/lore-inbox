Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264625AbUEaNhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264625AbUEaNhn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 09:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264627AbUEaNfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 09:35:34 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:48834 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264526AbUEaNfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 09:35:07 -0400
Date: Sun, 30 May 2004 20:40:31 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: Resume enhancement: restore pci config space
Message-ID: <20040530184031.GF997@openzaurus.ucw.cz>
References: <20040526203524.GF2057@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040526203524.GF2057@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> One can rightfully argue that the driver resume method should do this, and
> yes that is right. So the patch only does it for devices that don't have a
> resume method. Like the main PCI bridge on my testbox of which the bios so
> nicely forgets to restore the bus master bit during resume.. With this patch
> my testbox resumes just fine while it, well, wasn't all too happy as you can
> imagine without a busmaster pci bridge.
...
> +/* 
> + * Default resume method for devices that have no driver provided resume,
> + * or not even a driver at all.
> + */
> +static void pci_default_resume(struct pci_dev *pci_dev)
> +{

Perhaps this should not be static so that drivers don't
need to duplicate this?
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

