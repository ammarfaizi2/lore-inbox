Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbUCROuW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 09:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbUCROuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 09:50:22 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:60835 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261817AbUCROuR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 09:50:17 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] Modular IDE drivers
Date: Thu, 18 Mar 2004 15:58:07 +0100
User-Agent: KMail/1.5.3
References: <405969F1.2050103@suse.de>
In-Reply-To: <405969F1.2050103@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403181558.07657.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 of March 2004 10:20, Hannes Reinecke wrote:
> Hi all,

Hi,

> the attached patch is required to have modular IDE drivers announce
> themselves properly in modules.pcimap. Two drivers are missing
> (triflex.c and cmd640.c) since they haven't been converted to new-style
> PCI drivers.

triflex.c driver is converted but pci_device_id table is in triflex.h.

cmd640.c may be hard to convert due to fact that this chipset
doesn't support config write cycles (more details in cmd640.c).

You missed cs5520.c, cs5530.c and freshly added atiixp.c.
Anyway I corrected the patch and pushed it to Linus, thanks!

Regards,
Bartlomiej

> Any reason _not_ to apply this patch?
>
> Please keep me cc'ed as I'm not subscribed.
>
> Cheers,
>
> Hannes

