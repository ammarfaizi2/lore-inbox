Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757005AbWLEXvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757005AbWLEXvh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 18:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757046AbWLEXvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 18:51:37 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42701 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756986AbWLEXvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 18:51:36 -0500
Date: Tue, 5 Dec 2006 23:57:01 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org,
       "Tejun Heo" <htejun@gmail.com>, "Jeff Garzik" <jgarzik@pobox.com>
Subject: Re: [PATCH] ide-cd: Handle strange interrupt on the Intel ESB2
Message-ID: <20061205235701.74b4c07b@localhost.localdomain>
In-Reply-To: <58cb370e0612051523t2feba049rae830c9fa593b1c1@mail.gmail.com>
References: <20061204163057.2f27a12a@localhost.localdomain>
	<58cb370e0612051523t2feba049rae830c9fa593b1c1@mail.gmail.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006 00:23:03 +0100
"Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com> wrote:

> Looks good but aren't this trying to fix the same ICH
> issue that is fixed in libata by ap->ops->irq_clear(ap)?
> 
> [ please see Tejun's mail: http://lkml.org/lkml/2006/11/15/94 ]
> 
> If so shouldn't we apply this fix for all ICH5/6/7/8 chipsets?

Possibly. Thats one reason I made it a quirk bit. I'd certainly expect it
to be a group of related chipsets.

> Also shouldn't the fix be in IRQ handler?  Currently the fix is limited
> to ide-cd driver which seems to be the wrong place as the problem
> is supposed to happen also when using other IDE device drivers
> or/and other ATA/ATAPI devices?

The problem has only be observed with CD devices doing PIO ATAPI
commands. I am not aware of an Intel errata document that characterises
this errata so anything else so cannot guess further. Perhaps Intel can
advise ?

Alan
