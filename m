Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161033AbWGZUWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161033AbWGZUWl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 16:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161034AbWGZUWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 16:22:40 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:18144 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161033AbWGZUWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 16:22:40 -0400
Subject: Re: why does nforce pata controller need ide0=ata66  ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jimmy.Jazz@gmx.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44C0E510.7000805@gmx.net>
References: <44C0E510.7000805@gmx.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 26 Jul 2006 21:41:22 +0100
Message-Id: <1153946482.13509.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-07-21 am 16:30 +0200, ysgrifennodd Jimmy Jazz:
> What puzzles me is the kernel message: ide_setup: ide0=ata66 -- OBSOLETE
> OPTION, WILL BE REMOVED SOON!
> 
> So, i guess, if the option will be removed soon, it is no more necessary
> to worry about it because PATA drives are "end of life" or the option
> will certainly (hopefully) be replaced with a new one ;).

The current plan is that drivers/ide goes away and libata takes over.

> Would it be a way in the future to make ata66 drives and over work at
> their nominal speed when the chipset capabilities are not well
> recognized by the kernel driver ?

They should always be correctly detected.

> Have i simply misconfigured anything ?

Probably not. Make sure the cable itself is the right way around and can
you also send me an lspci -vxxx, as that will let me see the cable and
udma setup bits on your machine and investigate further.

Alan

