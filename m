Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946851AbWKAMTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946851AbWKAMTe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 07:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946850AbWKAMTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 07:19:34 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:1720 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946843AbWKAMTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 07:19:33 -0500
Subject: Re: AHCI should try to claim all AHCI controllers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Conke Hu <conke.hu@amd.com>,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610312120200.25218@g5.osdl.org>
References: <FFECF24D2A7F6D418B9511AF6F358602F2CE9E@shacnexch2.atitech.com>
	 <45482BA7.6070904@pobox.com>
	 <Pine.LNX.4.64.0610312120200.25218@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 01 Nov 2006 12:23:03 +0000
Message-Id: <1162383783.11965.116.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Maw, 2006-10-31 am 21:22 -0800, ysgrifennodd Linus Torvalds:
> (We had the same issue with "PCI IDE controller". Some PCI IDE controllers 
> are clearly exactly that from a programming interface standpoint, but 
> because they support RAID in hardware, they claim to be RAID controllers, 
> since that is more "glamorous". Gaah ;^).

Actually its far uglier than that. With one exception they don't support
hardware raid mode, they use the RAID class tag to stop other OS drivers
grabbing the interface or seeing it directly as un-raided software raid.

Alan
