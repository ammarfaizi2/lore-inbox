Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264134AbTLAWGw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 17:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264136AbTLAWGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 17:06:52 -0500
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:37133 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S264134AbTLAWGs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 17:06:48 -0500
Message-ID: <3FCBBB62.2030907@rackable.com>
Date: Mon, 01 Dec 2003 14:06:26 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Stark <gsstark@mit.edu>
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata in 2.4.24?
References: <Pine.LNX.4.44.0312010836130.13692-100000@logos.cnet>	<3FCB8312.3050703@rackable.com> <87fzg4ckej.fsf@stark.dyndns.tv>	<3FCBB15F.7050505@rackable.com> <87ad6ccixk.fsf@stark.dyndns.tv>
In-Reply-To: <87ad6ccixk.fsf@stark.dyndns.tv>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Dec 2003 22:06:46.0660 (UTC) FILETIME=[69681440:01C3B857]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Stark wrote:
> Samuel Flory <sflory@rackable.com> writes:
> 
> 
>>   What chipset are you using?  Assumming that hda is your sata drive. What are
>>the results of the following "hdarm -t /dev/hda" "hdparm -dvi /dev/hda"   The
>>ICH5 chipset is the only chipset I've found that works well without libata.
> 
> 
> Ah, my motherboard is in fact an ICH5 I believe.
> Incidentally my kernel is actually 2.4.23-pre4.
> 

   Generally the ICH5 support just works, but it may not be doing dma. 
I've have some stability issues with some configs before I started 
applying libata patches to my kernel.  This was a long time ago.  Also 
ctcs pounds on things pretty hard.

http://marc.theaimsgroup.com/?l=linux-kernel&m=105666857613064&w=2

> Is there any documentation about what libata is and what it does differently
> from the stock kernel? 

   Libata is just another driver patch for the linux kernel.  It uses 
the scsi subsystem instead of the ide subsystem.  Jeff has pdf some 
where, but as I remember it was geared for developers.

> Why is it being developed separately instead of as a
> set of new drivers in the kernel like normal? 
> 

   What? Most drivers are developed outside the main kernel tree. 
Marcelo's job is to stop people from doing that kind of thing in the 
stable tree;-)

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>

