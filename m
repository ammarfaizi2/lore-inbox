Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbTLJBpN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 20:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTLJBpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 20:45:13 -0500
Received: from 66-141-88-11.ded.swbell.net ([66.141.88.11]:35854 "EHLO
	lcisp.com") by vger.kernel.org with ESMTP id S262055AbTLJBpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 20:45:09 -0500
From: "Kevin Krieser" <kkrieser@lcisp.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: very large FAT16 partition not readable on 2.6.0-test11
Date: Tue, 9 Dec 2003 19:45:12 -0600
Message-ID: <NDBBLFLJADKDMBPPNBALOEDBCLAB.kkrieser@lcisp.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <3FD65CCA.3000408@triphoenix.de>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, there is an extension to 4GB that NT used in the 4.0 days (maybe
earlier?).

Don't know if the Linux driver supports it.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Dennis
Bliefernicht
Sent: Tuesday, December 09, 2003 5:38 PM
To: linux-kernel@vger.kernel.org
Subject: Re: very large FAT16 partition not readable on 2.6.0-test11


Greg KH wrote:
> I just bought a new USB/Firewire external drive.  It comes pre-formatted
> as FAT16 (or so shows fdisk) as one big 80Gb partition.  Unfortunately,
> Linux can't seem to mount this partition, and I get the following dmesg
> output when trying to mount the partition:
> 	FAT: bogus number of reserved sectors
> 	VFS: Can't find a valid FAT filesystem on dev sdb1.

Well, according to my sources FAT16 cannot sustain any partition larger
than 2GiB, so 80GiB is probably a lot more than it can handle. Anyway,
sdb1 is lacking any type of header and sdb containt something, but not a
FAT header afaik. So probably theres just a partition table entry but
not formatted.


