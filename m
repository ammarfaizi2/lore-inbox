Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946118AbWKAFfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946118AbWKAFfW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946149AbWKAFfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:35:16 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:14044 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1946118AbWKAFfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:35:13 -0500
Message-ID: <4548320D.5090601@pobox.com>
Date: Wed, 01 Nov 2006 00:35:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Conke Hu <conke.hu@amd.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: AHCI should try to claim all AHCI controllers
References: <FFECF24D2A7F6D418B9511AF6F358602F2CE9E@shacnexch2.atitech.com> <45482BA7.6070904@pobox.com> <Pine.LNX.4.64.0610312120200.25218@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610312120200.25218@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 1 Nov 2006, Jeff Garzik wrote:
>> For the benefit of others, some background:  we should not be -removing- any
>> PCI IDs due to this, because quite often the PCI class code will be RAID or
>> something else, yet still be drive-able with this ahci driver.
> 
> Well, it might obviously be worthwhile removing the PCI ID's that actually 
> do say that they are AHCI. Maybe that's not all of them, but I wouldn't be 
> surprised if it's actually the majority of them..

The same PCI ID maps to either RAID or AHCI.  The PCI ID only changes 
when it's no longer in AHCI mode (IDE/legacy mode).

To confuse matters even further, sometimes you can use AHCI even though 
it claims it is in IDE mode.  And the reverse is -often- true:  you can 
usually use legacy IDE mode even if the PCI ID and class code claim AHCI 
mode.

Who knows what beasts lurk behind the same PCI ID...


> (We had the same issue with "PCI IDE controller". Some PCI IDE controllers 
> are clearly exactly that from a programming interface standpoint, but 
> because they support RAID in hardware, they claim to be RAID controllers, 
> since that is more "glamorous". Gaah ;^).

Heck these days 'RAID' is a marketing requirement for your hardware, 
regardless of its capabilities...

	Jeff



