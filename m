Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750791AbVJIPQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750791AbVJIPQV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 11:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbVJIPQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 11:16:20 -0400
Received: from alpha.polcom.net ([217.79.151.115]:5314 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S1750711AbVJIPQU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 11:16:20 -0400
Date: Sun, 9 Oct 2005 17:18:11 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Daniel Drake <dsd@gentoo.org>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       posting@blx4.net, vsu@altlinux.ru
Subject: Re: [PATCH] via82cxxx IDE: Remove /proc/via entry
In-Reply-To: <58cb370e0509290027404f5224@mail.gmail.com>
Message-ID: <Pine.LNX.4.63.0510091707220.21130@alpha.polcom.net>
References: <43146CC3.4010005@gentoo.org>  <58cb370e05083008121f2eb783@mail.gmail.com>
  <43179CC9.8090608@gentoo.org>  <58cb370e050927062049be32f8@mail.gmail.com>
  <433B16BD.7040409@gentoo.org>  <Pine.LNX.4.63.0509290042160.21130@alpha.polcom.net>
 <58cb370e0509290027404f5224@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2005, Bartlomiej Zolnierkiewicz wrote:

> On 9/29/05, Grzegorz Kulewski <kangur@polcom.net> wrote:
>> On Wed, 28 Sep 2005, Daniel Drake wrote:
>>
>>> This entry adds needless complication to the driver as it requires the use of
>>> global variables to be passed into via_get_info(), making things quite ugly
>>> when we try and make this driver support multiple controllers simultaneously.
>>>
>>> This patch removes /proc/via for simplicity.
>>
>> Is similar data available from sysfs?
>>
>> As a user of this controller, I think that if it is not then this patch
>> should be changed to export it or should be dropped. The data from that
>> file is really helpfull in debugging problems (for example related to bad
>> cables or breaking disks/cdroms).
>
> Could you please give some details (which data is useful)?

Sorry for delay - I was very busy during past week.

Well, I guess that thanks to this file I am able to know that the drive is 
connected to via chipset and not to some pseudo raid controller (it is 
important if I am working remotely), if it has 80w cables attached, what 
is attached where, what are controller parameters, dma rate and timings 
(if they are strange I can suspect that something bad is happening with 
the drive / controler).

I am not saying that these data are not available elsewhere (but some are 
not for sure). But they are presented nicely in one standard place and 
this is in my opinion good.

But I understand the desire to remove all files that can be removed from 
/proc. So I am just suggesting to move some of the data (like type of 
cable detected for example) to sysfs if they are not already there.


Thanks,

Grzegorz Kulewski
