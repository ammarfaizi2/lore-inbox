Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261812AbSJIPP2>; Wed, 9 Oct 2002 11:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261813AbSJIPP2>; Wed, 9 Oct 2002 11:15:28 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:9634 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261805AbSJIPP0>; Wed, 9 Oct 2002 11:15:26 -0400
Subject: Re: [PATCH] 2.5.41, cciss, add rescan disk ioctl (6 of 5 :-)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: steve.cameron@hp.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de
In-Reply-To: <20021009084659.A8912@zuul.cca.cpqcorp.net>
References: <20021009084659.A8912@zuul.cca.cpqcorp.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Oct 2002 16:31:41 +0100
Message-Id: <1034177501.1970.50.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-09 at 15:46, Stephen Cameron wrote:
> This patch adds the CCISS_RESCANDISK ioctl which is meant to be used in a 
> configuration like Steeleye's Lifekeeper.  Two hosts connect to the storage, 
> one reserves disks.  The 2nd will not be able to read the partition 
> information because of the reservations.  In the event the 1st system fails, 
> the 2nd can detect this, (via special hardware + software typically) and then 
> take over the storage and rescan he disks via this ioctl.
> Applies to 2.5.41 (after applying my prior 4 patches to 2.5.4[01] )

Why not use the existing rescanning ioctls like BLKRRPART - what else is
different to need a custom ioctl?

