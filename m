Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753263AbWKCWBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263AbWKCWBZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 17:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753485AbWKCWBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 17:01:25 -0500
Received: from main.gmane.org ([80.91.229.2]:9628 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1753263AbWKCWBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 17:01:24 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: New filesystem for Linux
Date: Fri, 3 Nov 2006 22:00:57 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrneknfdo.2in.olecom@flower.upol.cz>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz> <Pine.LNX.4.63.0611022346450.14187@alpha.polcom.net> <Pine.LNX.4.64.0611030015150.3266@artax.karlin.mff.cuni.cz> <Pine.LNX.4.63.0611030022110.14187@alpha.polcom.net> <Pine.LNX.4.64.0611030228470.7781@artax.karlin.mff.cuni.cz>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>, Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, Grzegorz Kulewski <kangur@polcom.net>
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-11-03, Mikulas Patocka wrote:
[]
>> Well, at least for XFS everybody tell that it should be used with UPS only if 
>> you really care about your data. I think it has something to do with heavy 
>> in-RAM caching this filesystem does.
>
> System is allowed to cache anything unless sync/fsync is called. Someone 
> told that XFS has some bugs that if crashed incorrectly, it can lose 
> already synced data ... don't know. Plus it has that infamous feature (not 
> a bug) that it commits size-increase but not data and you see zero-filed 
> files.

AFAIK, XFS by design must provide _file system_ consistency, not data.

[]
>> PS. Do you have any benchmarks of your filesystem? Did you do any longer 
>> automated tests to prove it is not going to loose data to easily?
>
> I have, I may find them and post them. (but the university wants me to 
> post them to some conference, so I should keep them secret :-/)

Interesting to know, how "another one" FS is quick and stable.

On my new hardware, with dual core CPU 3.4G, 1G of RAM, 1/2TB disk space
(office pro, yes *office* (pro)), `dd' can suck 50M/s, (running and)
extracting 2.6.19-rc2 on fresh 20Gb partition (xfs,jfs) yields nearly 4M/s.

As for ordinary user it seems very slowly.

Ext2 (not ext3) is as fast as shmfs, until RAM will be full.
And after 13 cycles XFS has 11-12 directories with good linux source,
ext2 6-7 (IIRC). On start of 14th cycle i pushed reset button, btw.

Mounting & repairing XFS took less than minute; e2fsck spent more time
on printing, rather than reparing, i think (:.

Want to create another one? OK, but why not to improve existing? >/dev/null
____

