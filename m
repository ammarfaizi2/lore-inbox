Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319344AbSIKVXa>; Wed, 11 Sep 2002 17:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319345AbSIKVXa>; Wed, 11 Sep 2002 17:23:30 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:12797
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319344AbSIKVX3>; Wed, 11 Sep 2002 17:23:29 -0400
Subject: Re: CDROM driver does not support Linux partition tables
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Phil Stracchino <alaric@babcom.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020911211959.GA31724@babylon5.babcom.com>
References: <20020904181952.GA1158@babylon5.babcom.com>
	<1031182512.3017.139.camel@irongate.swansea.linux.org.uk> 
	<20020911211959.GA31724@babylon5.babcom.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-7) 
Date: 11 Sep 2002 22:28:35 +0100
Message-Id: <1031779715.2838.4.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-11 at 22:19, Phil Stracchino wrote:
>  
> A deficiency in the Linux CDROM driver was just brought to my attention.
> Even on a kernel configured with support for UFS and Sun partition
> tables, it doesn't appear to be possible to mount any but the first
> slice of a Sun CDROM containing multiple slices.  Essentially, it seems
> that Solaris partition table support doesn't trickle down to the CDROM
> driver.
> 
> Is this something that's supposed to happen, and is there a reason why
> it's not supported, or is it simply that no-one has asked for it to be
> supported and/or no-one has gotten around to implementing it because of 
> lack of demand?

It ought to be supportable on scsi cd or with ide-scsi. ide-cd has no
minor space for partitioning, ide-scsi/sr do support partitions.

