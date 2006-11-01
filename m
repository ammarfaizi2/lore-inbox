Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946092AbWKAFW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946092AbWKAFW6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:22:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946081AbWKAFW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:22:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:2474 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946078AbWKAFW5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:22:57 -0500
Date: Tue, 31 Oct 2006 21:22:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Conke Hu <conke.hu@amd.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: AHCI should try to claim all AHCI controllers
In-Reply-To: <45482BA7.6070904@pobox.com>
Message-ID: <Pine.LNX.4.64.0610312120200.25218@g5.osdl.org>
References: <FFECF24D2A7F6D418B9511AF6F358602F2CE9E@shacnexch2.atitech.com>
 <45482BA7.6070904@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 1 Nov 2006, Jeff Garzik wrote:
> 
> For the benefit of others, some background:  we should not be -removing- any
> PCI IDs due to this, because quite often the PCI class code will be RAID or
> something else, yet still be drive-able with this ahci driver.

Well, it might obviously be worthwhile removing the PCI ID's that actually 
do say that they are AHCI. Maybe that's not all of them, but I wouldn't be 
surprised if it's actually the majority of them..

(We had the same issue with "PCI IDE controller". Some PCI IDE controllers 
are clearly exactly that from a programming interface standpoint, but 
because they support RAID in hardware, they claim to be RAID controllers, 
since that is more "glamorous". Gaah ;^).

		Linus
