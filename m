Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbWKCWmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWKCWmO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 17:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753519AbWKCWmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 17:42:14 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:22439 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751471AbWKCWmN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 17:42:13 -0500
Date: Fri, 3 Nov 2006 23:42:12 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Oleg Verych <olecom@flower.upol.cz>
Cc: Grzegorz Kulewski <kangur@polcom.net>, linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <slrneknfdo.2in.olecom@flower.upol.cz>
Message-ID: <Pine.LNX.4.64.0611032317490.2201@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
 <Pine.LNX.4.63.0611022346450.14187@alpha.polcom.net>
 <Pine.LNX.4.64.0611030015150.3266@artax.karlin.mff.cuni.cz>
 <Pine.LNX.4.63.0611030022110.14187@alpha.polcom.net>
 <Pine.LNX.4.64.0611030228470.7781@artax.karlin.mff.cuni.cz>
 <slrneknfdo.2in.olecom@flower.upol.cz>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> []
>>> PS. Do you have any benchmarks of your filesystem? Did you do any longer
>>> automated tests to prove it is not going to loose data to easily?
>>
>> I have, I may find them and post them. (but the university wants me to
>> post them to some conference, so I should keep them secret :-/)
>
> Interesting to know, how "another one" FS is quick and stable.
>
> On my new hardware, with dual core CPU 3.4G, 1G of RAM, 1/2TB disk space
> (office pro, yes *office* (pro)), `dd' can suck 50M/s, (running and)
> extracting 2.6.19-rc2 on fresh 20Gb partition (xfs,jfs) yields nearly 4M/s.
>
> As for ordinary user it seems very slowly.

So try my filesystem and tell me if I have it better :)

> Ext2 (not ext3) is as fast as shmfs, until RAM will be full.
> And after 13 cycles XFS has 11-12 directories with good linux source,
> ext2 6-7 (IIRC). On start of 14th cycle i pushed reset button, btw.

My Spadfs will leave there snapshot of situation at most 2 minutes ago 
(this sync interval can be changed with mount option).

> Mounting & repairing XFS took less than minute; e2fsck spent more time
> on printing, rather than reparing, i think (:.
>
> Want to create another one? OK, but why not to improve existing? >/dev/null

Because redesign is sometimes better.

And you can't generally improve XFS and JFS by simplifying their 
structures, because people would scream about incompatibility then.

Mikulas
