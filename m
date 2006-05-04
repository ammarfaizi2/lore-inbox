Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbWEDPBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbWEDPBB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 11:01:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWEDPBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 11:01:00 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:52378 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751492AbWEDPA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 11:00:59 -0400
In-Reply-To: <20060504144259.GA26668@kroah.com>
Subject: Re: [PATCH] s390: Hypervisor File System
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, ioe-lkml@rameria.de,
       joern@wohnheim.fh-wedel.de, linux-kernel@vger.kernel.org,
       mschwid2@de.ibm.com, penberg@cs.helsinki.fi
X-Mailer: Lotus Notes Build V70_M4_01112005 Beta 3NP January 11, 2005
Message-ID: <OF99AF266B.81368F01-ON42257164.00523E52-42257164.0052802A@de.ibm.com>
From: Michael Holzheu <HOLZHEU@de.ibm.com>
Date: Thu, 4 May 2006 17:01:07 +0200
X-MIMETrack: Serialize by Router on D12ML061/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 04/05/2006 17:02:09
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Greg KH <greg@kroah.com> wrote on 05/04/2006 04:42:59 PM:
> > I would suggest do do it like /sys/kernel and put the code
> > into kernel/ksysfs.c and include/linux/kobject.h
>
> No, if you do that then every kernel gets that mount point, when almost
> no one really wants it :)
>
> If you leave it as a separate file, then the build system can just
> include the file as needed.
>

So you want a new config option CONFIG_HYPERVISOR?

When no one except for us wants it, wouldn't it be best
then to create /sys/hypervisor first in the hypfs code?

If someone else needs it in the future, we still can move
it common code.

Michael

