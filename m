Return-Path: <linux-kernel-owner+w=401wt.eu-S964981AbWLMOqI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbWLMOqI (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 09:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWLMOqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 09:46:08 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47503 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S964981AbWLMOqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 09:46:07 -0500
Date: Wed, 13 Dec 2006 14:53:25 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: akpm@osdl.org, bzolnier@gmail.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1] Toshiba TC86C001 IDE driver
Message-ID: <20061213145325.41fc4300@localhost.localdomain>
In-Reply-To: <45800B4D.8000906@ru.mvista.com>
References: <200612130148.34539.sshtylyov@ru.mvista.com>
	<20061212234145.557cb035@localhost.localdomain>
	<45800B4D.8000906@ru.mvista.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>+static int tc86c001_busproc(ide_drive_t *drive, int state)
> >>+{
> 
> > Waste of space having a busproc routine. The maintainer removed all the
> > usable hotplug support from old IDE so this might as well be dropped.
> 
>     Don't know what you mean, ioctl is still there...

You can turn the bus on and off but there is no ability to actually swap
drives except in RHEL4 and 2.4.x-ac kernels. Hence "waste of space"

> > "Close but no cookie": please fix the PCI quirk to match the current -mm
> > behaviour with the ATA resource tree. Otherwise - nice driver.
> 
>     Ugh, I should've expected some backstab from -mm tree...

If it is native only then there are no problems with the quirk 

Acked-by: Alan Cox <alan@redhat.com>
