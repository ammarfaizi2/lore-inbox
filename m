Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWCALhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWCALhO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 06:37:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbWCALhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 06:37:14 -0500
Received: from lucidpixels.com ([66.45.37.187]:12934 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1030187AbWCALhM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 06:37:12 -0500
Date: Wed, 1 Mar 2006 06:37:05 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Mark Lord <liml@rtr.ca>
cc: "Eric D. Mudama" <edmudama@gmail.com>, Jeff Garzik <jgarzik@pobox.com>,
       David Greaves <david@dgreaves.com>, Tejun Heo <htejun@gmail.com>,
       linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>
Subject: Re: LibPATA code issues / 2.6.15.4
In-Reply-To: <4404F31D.90407@rtr.ca>
Message-ID: <Pine.LNX.4.64.0603010634180.15332@p34>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <4401122A.3010908@rtr.ca>
  <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca>  <4403704E.4090109@rtr.ca>
 <4403A84C.6010804@gmail.com>  <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com>
  <44046CE6.60803@rtr.ca> <44046D86.7050809@pobox.com>
 <311601c90602280857x3f102af5l31c9a0ac1a896b4e@mail.gmail.com> <4404F31D.90407@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2006, Mark Lord wrote:

> Eric D. Mudama wrote:
>> those drives should support all FUA opcodes properly, both queued and 
>> unqueued
>
> His first drive (sda) does not support queued commands at all,
> but the newer firmware in his second drive (sdb) does support NCQ.
>
> Both drives support FUA.
>
> cheers
>

To trust or not to trust?

I have a 400GB SATA drive: WDC WD4000KD-00N.  With these errors in dmesg 
that have been mentioned throughout the thread, should I trust Linux using 
this drive, or should I remove it/wait until a patch is released to 
address this issue?

Also, in the forums (storagereview.com I believe), it has been noted that 
these drives do NOT work on the Intel ICH5 controller, and this turned out 
to be true, when I put it on the Intel ICH5, the box stalls for 2-3 
minutes and then it does not see the drive.  However, on the Silicon 
Image, Inc. SiI 3112 chipset or Promise SATA/150 TX2 it works okay but it 
has those errors in dmesg.

My question is, performing long and short smart tests, everything is 
physically ok with the drive; however, I probably should not use this 
drive for anything important in Linux, comments?

Justin.
