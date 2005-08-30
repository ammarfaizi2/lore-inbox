Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbVH3TJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbVH3TJR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 15:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbVH3TJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 15:09:17 -0400
Received: from dwdmx4.dwd.de ([141.38.3.230]:55007 "EHLO dwdmx4.dwd.de")
	by vger.kernel.org with ESMTP id S932386AbVH3TJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 15:09:16 -0400
Date: Tue, 30 Aug 2005 19:08:55 +0000 (GMT)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@diagnostix.dwd.de
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-raid <linux-raid@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Where is the performance bottleneck?
In-Reply-To: <Pine.LNX.4.44.0508291530310.14200-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.61.0508301859500.25574@diagnostix.dwd.de>
References: <Pine.LNX.4.44.0508291530310.14200-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Aug 2005, Mark Hahn wrote:

>> The U320 SCSI controller has a 64 bit PCI-X bus for itself, there is no other
>> device on that bus. Unfortunatly I was unable to determine at what speed
>> it is running, here the output from lspci -vv:
> ...
>>                  Status: Bus=2 Dev=4 Func=0 64bit+ 133MHz+ SCD- USC-, DC=simple,
>
> the "133MHz+" is a good sign.  OTOH the latency (72) seems rather low - my
> understanding is that that would noticably limit the size of burst transfers.
>
I have tried with 128 and 144, but the transfer rate is only a little
bit higher barely measurable. Or what values should I try?

>
>> Version  1.03        ------Sequential Output------ --Sequential Input- --Random-
>>                       -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
>> Machine         Size K/sec %CP K/sec %CP K/sec %CP K/sec %CP K/sec %CP  /sec %CP
>> Raid0 (8 disk)15744M 54406  96 247419 90 100752 25 60266  98 226651 29 830.2   1
>> Raid0s(4 disk)15744M 54915  97 253642 89 73976  18 59445  97 198372 24 659.8   1
>> Raid0s(4 disk)15744M 54866  97 268361 95 72852  17 59165  97 187183 22 666.3   1
>
> you're obviously saturating something already with 2 disks.  did you play
> with "blockdev --setra" setings?
>
Yes, I did play a little bit with it but this only changed read performance,
it made no measurable difference when writting.

Thanks,
Holger

