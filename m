Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751479AbWEDKWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbWEDKWf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 06:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWEDKWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 06:22:35 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:7457 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751479AbWEDKWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 06:22:35 -0400
In-Reply-To: <20060503221037.GA17181@kroah.com>
Subject: Re: [PATCH] s390: Hypervisor File System
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, ioe-lkml@rameria.de,
       joern@wohnheim.fh-wedel.de, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com, penberg@cs.helsinki.fi
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OF3B24B2D7.E24F3E4F-ON42257164.0038D454-42257164.0039028B@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Thu, 4 May 2006 12:22:42 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 04/05/2006 12:23:44
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote on 05/04/2006 12:10:37 AM:

> > Fine with me! Then I will create /sys/hypervisor/s390. Should I
> > create /sys/hypervisor in the hpyfs code or should it be
> > created somewhere else?
>
> Somewhere else is probably best.
>
> drivers/base/hypervisor.c ?
>

We could do that, but then we have to create two new files
hypervisor.c and hypervisor.h just for one new mountpoint
in sysfs.

I would suggest do do it like /sys/kernel and put the code
into kernel/ksysfs.c and include/linux/kobject.h

Michael

