Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263205AbTLIXho (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 18:37:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263345AbTLIXho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 18:37:44 -0500
Received: from dd1802.kasserver.com ([81.209.148.61]:56199 "EHLO
	dd1802.kasserver.com") by vger.kernel.org with ESMTP
	id S263205AbTLIXhn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 18:37:43 -0500
Message-ID: <3FD65CCA.3000408@triphoenix.de>
Date: Wed, 10 Dec 2003 00:37:46 +0100
From: Dennis Bliefernicht <news.REMOVEME@triphoenix.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031119
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: very large FAT16 partition not readable on 2.6.0-test11
References: <10Zjf-TI-11@gated-at.bofh.it>
In-Reply-To: <10Zjf-TI-11@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

