Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319091AbSHTPhK>; Tue, 20 Aug 2002 11:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319160AbSHTPhK>; Tue, 20 Aug 2002 11:37:10 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:47355 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319091AbSHTPhJ>; Tue, 20 Aug 2002 11:37:09 -0400
Subject: Re: IDE-TNG what to do ?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Jones <little.jones.family@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <2CEAF5A2-B451-11D6-A001-00050291EC35@ntlworld.com>
References: <2CEAF5A2-B451-11D6-A001-00050291EC35@ntlworld.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 20 Aug 2002 16:41:52 +0100
Message-Id: <1029858112.22983.52.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-08-20 at 16:26, John Jones wrote:
> IDE-TNG should ONLY deal with Serial ATA and ONLY chipset support not 
> PCI based implementations and should be a config option (keep it simple 
> as possible).

SATA bridges attach to any IDE device and any IDE controller. SATA still
uses PIO. SATA still has to deal with all the other legacy crap.

The view that new IDE somehow gets rid of the old cruft is alas not born
out by the reality. 

In terms of what works. As far as I can tell right now all the PCI stuff
works in the current -ac cleanup code. There is a weird ide-scsi report
and one person whose drives have run off somewhere and hidden. Other
than that its working as well - and in some cases better.

The 2.5 side is about getting the new request queue/bio logic right
which is something I've not looked into

Alan
