Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbTBTSs7>; Thu, 20 Feb 2003 13:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266431AbTBTSs7>; Thu, 20 Feb 2003 13:48:59 -0500
Received: from achenar.cyan.com ([216.64.128.131]:45249 "EHLO cyan.com")
	by vger.kernel.org with ESMTP id <S261364AbTBTSs6>;
	Thu, 20 Feb 2003 13:48:58 -0500
From: "Rob Emanuele" <rje@cyan.com>
To: "'Neil Brown'" <neilb@cse.unsw.edu.au>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Fixing a non-redundant raid
Date: Thu, 20 Feb 2003 10:59:03 -0800
Organization: Cyan Worlds, Inc.
Message-ID: <000001c2d912$22da8460$a301a8c0@rje1xp>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
In-Reply-To: <15954.51227.385648.487733@notabene.cse.unsw.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!  It all worked and the data is consistant.

You guys rock!

--Rob

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Neil Brown
Sent: Tuesday, February 18, 2003 3:56 PM
To: Rob Emanuele
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fixing a non-redundant raid


On Tuesday February 18, rje@cyan.com wrote:
> I've got a raid that I was running w/o a spare disk.  One of the 
> drives was being flakey and I restarted the machine and I was 
> wondering if I can recover the data on the raid.  It did not have a 
> spare disk.  There are 12 drives in the stripe set.  According the the

> logs one drive isn't listed as a raid drive (sdi1) and the other's 
> (sdb1) event counter is behind.  Is there anything I can do or is it a

> loss and I should rebuild the array with a hot spare :)?
> 
> I attached the logs.
> 
> Thanks for any help,
> 
> Rob

Get mdadm, assemble with --force.
e.g.

 mdadm --assemble --force /dev/md0 /dev/sd[abcdefghijkl]1

NeilBrown

http://www.kernel.org/pub/linux/utils/raid/mdadm/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in the body of a message to majordomo@vger.kernel.org More majordomo
info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

