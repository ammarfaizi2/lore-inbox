Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbUKALNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbUKALNh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 06:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbUKALNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 06:13:34 -0500
Received: from 81-223-104-78.krugerstrasse.xdsl-line.inode.at ([81.223.104.78]:47507
	"EHLO mail.sk-tech.net") by vger.kernel.org with ESMTP
	id S261734AbUKALN1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 06:13:27 -0500
Date: Mon, 1 Nov 2004 12:13:51 +0100 (CET)
From: Kianusch Sayah Karadji <kianusch@sk-tech.net>
To: Neil Brown <neilb@cse.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Raid1 DM vs MD
In-Reply-To: <16773.35825.194304.830001@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.61.0411011141001.1412@merlin.sk-tech.net>
References: <Pine.LNX.4.61.0410311902300.1819@merlin.sk-tech.net>
 <16773.35825.194304.830001@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>> Should I use MD or DM?
>
> I would say "md", but I am biased.

:)

> It is unlikely that support for useful functionality will go away. I 
> would prefer to see all arrays being assembled by an initrd-like thing 
> (initramfs??) but wouldn't dream of encouraging that until it was easy 
> to use and widely used.  We aren't there yet.

It seem that there has been some changes lately on the way when and by 
whom the RAID devices are created (especially in the 2.6.x stream) ... but 
one of the most frustrating experiences is the lack of decent 
documentation - or maybe some examples... Raid Support on DM seems not be 
documented at all ... and than there are some "SubTypes" like Raid 
Semi-Raid-Controllers (CMD649 etc.).  Or maybe I'm searched the wrong way 
on google?  Is there a central resource on the net for Linux & Raid I do 
not know of?

>> I had one MD-Raid1 where a good copy of the mirror was overwritten by 
>> the bad (old) copy ... I lost 3 Month worth of data and I am expecting 
>> loosing a linux project and in the worst case - even a court case :(
>
> That sounds very unfortunate.  Without knowing the details it is hard to 
> comment on why this might have happened and how it could have been 
> avoided, but with modern tools (mdadm) and a sufficiently modern kernel 
> (2.4 at least) this should never be able to happen (without deliberate 
> carelessness on the part of the sysadmin).

Hmmm ...

RedHat ES 2.x ... so no mdadm but raidtools ... The System was set up with 
HA-Linux so the sysadmin just had to initiate the TakeOver ... According 
to /dev/mdstat the System was okay ... but where do I see which copy is 
the "master" and where do I see in which direction the synchronisation is 
going to take place - before the raid is started?

Also I did not find a way to start the raid with just one of the mirrors.

As I said my biggest problem is the lack of documentation.

>> Sooner or later I'l migrate from SW-Raid to a HW-Raid-Controller ...
>
> Many believe that that would not be a win.  Personally I share that 
> view.  HW-Raid-Controllers are not "open".  md (and dm) SW-Raid is.

Well ... yes ... but with HW-Raid users do not have to think very much. 
(I'm talking about REAL Raid Controllers - like 3ware, ICP, Adaptek - not 
about Soft-Raid-Controllers) Simply plug in the HardDisk und look how the 
system syncs the disc.  And in my case I'm talking about mirroring 2TB 
Data ... MD takes up to 12Hours for syncing the raid - and 
stopping/starting MD during this time is always risky.

Kianusch
