Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266964AbSKUSo5>; Thu, 21 Nov 2002 13:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266965AbSKUSo5>; Thu, 21 Nov 2002 13:44:57 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:58247 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266964AbSKUSo5>; Thu, 21 Nov 2002 13:44:57 -0500
Subject: Re: Where is ext2/3 secure delete ("s") attribute?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kent Borg <kentborg@borg.org>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021121133922.M16336@borg.org>
References: <20021121125240.K16336@borg.org> <3DDD24E7.4040603@pobox.com> 
	<20021121133922.M16336@borg.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Nov 2002 19:20:58 +0000
Message-Id: <1037906458.7660.74.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-11-21 at 18:39, Kent Borg wrote:
> disk as the original data resided.  It seems this has to happen down
> in the file system if there is any hope of it working.  And even there
> it could use come help from the disk drive to make sure things can be
> made to happen where they appear to happen.

Very real issue. Your IDE and SCSI disks may randomly leave recoverable
data around if they hit a block that is iffy and mark it bad before it
fails. Flash file systems are very very likely to leave old data around
but fortunately are much smaller and therefore easy to encrypt or blank
wholesale (or indeed blowtorch erase 8))

