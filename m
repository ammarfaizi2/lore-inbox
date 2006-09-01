Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWIAIpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWIAIpX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 04:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWIAIpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 04:45:22 -0400
Received: from mail-gw1.turkuamk.fi ([195.148.208.125]:40374 "EHLO
	mail-gw1.turkuamk.fi") by vger.kernel.org with ESMTP
	id S932339AbWIAIpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 04:45:21 -0400
Message-ID: <44F7F376.4030203@kolumbus.fi>
Date: Fri, 01 Sep 2006 11:46:46 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
Cc: Keith Mannthey <kmannth@gmail.com>, akpm@osdl.org, tony.luck@intel.com,
       Linux Memory Management List <linux-mm@kvack.org>, ak@suse.de,
       bob.picco@hp.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 4/6] Have x86_64 use add_active_range() and free_area_init_nodes
References: <20060821134518.22179.46355.sendpatchset@skynet.skynet.ie>  <20060821134638.22179.44471.sendpatchset@skynet.skynet.ie>  <a762e240608301357n3915250bk8546dd340d5d4d77@mail.gmail.com>  <20060831154903.GA7011@skynet.ie>  <a762e240608311052h28843b2ege651e9fa82c49f2a@mail.gmail.com>  <Pine.LNX.4.64.0608311906300.13392@skynet.skynet.ie> <a762e240608312008v3e35b63ay46c95fbb6c3f15ec@mail.gmail.com> <Pine.LNX.4.64.0609010928010.25057@skynet.skynet.ie>
In-Reply-To: <Pine.LNX.4.64.0609010928010.25057@skynet.skynet.ie>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release
 6.5.4FP2 HF462|May 23, 2006) at 01.09.2006 11:45:07,
	Serialize by Router on marconi.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2
 HF462|May 23, 2006) at 01.09.2006 11:45:07,
	Serialize complete at 01.09.2006 11:45:07,
	Itemize by SMTP Server on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2
 HF462|May 23, 2006) at 01.09.2006 11:45:07,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 6.5.4FP2
 HF462|May 23, 2006) at 01.09.2006 11:45:19,
	Serialize complete at 01.09.2006 11:45:19
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> Right, it's all very clear now. At some point in the future, I'd like 
> to visit why SPARSEMEM-based hot-add is not always used but it's a 
> separate issue.
>
>> The add areas
>> are marked as RESERVED during boot and then later onlined during add.
>
> That explains the reserve_bootmem_node()
>
But pages are marked reserved by default. You still have to alloc the 
bootmem map for the the whole node range, including reserve hot add 
areas and areas beyond e820-end-of-ram. So all the areas are already 
reserved, until freed.

--Mika

