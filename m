Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbTKLDwI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 22:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbTKLDwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 22:52:08 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30662 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261522AbTKLDwE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 22:52:04 -0500
Message-ID: <3FB1AE54.2020208@pobox.com>
Date: Tue, 11 Nov 2003 22:51:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Prasanna Meda <pmeda@akamai.com>, tulip-users@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       danner@akamai.com, bmancuso@akamai.com
Subject: Re: Poss. bug in tulip driver since 2.4.7
References: <3FB1832C.35A52F9A@akamai.com> <20031111185419.0ff7a596.akpm@osdl.org>
In-Reply-To: <20031111185419.0ff7a596.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Prasanna Meda <pmeda@akamai.com> wrote:
> 
>>The inner for loop shown below was not
>> supposed to be  inside  the  outside  loop.
>> They  also use  the  same index i.
>> Due to  this, when mc_count is more than
>> 14,  with non ASIX chips,  panics, corruptions
>> and  denial of services to multicast addresses
>> can  result!
>>
>> http://lxr.linux.no/source/drivers/net/tulip/tulip_core.c#L1055
> 
> 
> So can you confirm that the driver works correctly with this change?
> 
> --- 25/drivers/net/tulip/tulip_core.c~tulip-hash-fix	2003-11-11 18:51:52.000000000 -0800
> +++ 25-akpm/drivers/net/tulip/tulip_core.c	2003-11-11 18:52:31.000000000 -0800


Patch looks sane to me...

