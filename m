Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263326AbSJWLnH>; Wed, 23 Oct 2002 07:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263785AbSJWLnG>; Wed, 23 Oct 2002 07:43:06 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:37995 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S263326AbSJWLnF>; Wed, 23 Oct 2002 07:43:05 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200210231149.g9NBn3G29403@devserv.devel.redhat.com>
Subject: Re: Linux 2.5.44-ac1
To: jason_williams@suth.com (Jason Williams)
Date: Wed, 23 Oct 2002 07:49:03 -0400 (EDT)
Cc: alan@redhat.com (Alan Cox),
       linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <1035373185.24550.21.camel@cermanius.suth.com> from "Jason Williams" at Oct 23, 2002 07:39:35 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> code within the ide_iomio_dma function in ide-dma.c The problem shows
> itself if you only enable the secondary channel of your IDE controller. 
> I understand this is a strange set up, but it could happen in a machine
> that boots off of SCSI and uses IDE disks for DATA or a CD Burner. I
> came up with a fix, some extra sanity checks before this line in the
> code:

Yes I saw the report. I've not applied it because I want to know how
the slave came not to have a hwif->mate even though it was bios disabled.
There are other things that really mean we should be assigning the hwif
pointers (eg hot plugging)
