Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265154AbSKEXwu>; Tue, 5 Nov 2002 18:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265162AbSKEXwu>; Tue, 5 Nov 2002 18:52:50 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:34711 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265154AbSKEXwt>; Tue, 5 Nov 2002 18:52:49 -0500
Subject: Re: [Evms-announce] EVMS announcement
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mike Diehl <mdiehl@dominion.dyndns.org>
Cc: Kevin Corry <corryk@us.ibm.com>, evms-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021105215100.E927E51CF@dominion.dyndns.org>
References: <02110516191004.07074@boiler>
	<20021105214012.C2B4651CF@dominion.dyndns.org> 
	<20021105215100.E927E51CF@dominion.dyndns.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Nov 2002 00:21:20 +0000
Message-Id: <1036542080.7386.24.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 21:11, Mike Diehl wrote:
> The biggest thing that EVMS had going for it was it's modular design.  As I 
> understand it, EVMS could even be used to manage the current MD and LVM 
> drivers.  I was looking forward to partition-level encryption, etc.  

Thats a seperate issue in the pile. You might want to do things like

			lvm2 volumes
                             |
                           RAID-5
                       /  |  \   \
                    4 encrypted volumes with different keys
                       |      |         |        |
                             4 NBD disk volumes over TCP
			    (or 4 iSCSI volumes)

                     4 physical disks in different jurisdictions


(and the physical disks or iscsi volumes might in fact be over lvm2 on
the othe end - its all a lot more modular than just volume management at
least at the kernel level - tools is different)



