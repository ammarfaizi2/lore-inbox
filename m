Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267235AbUIOSDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267235AbUIOSDl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 14:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267304AbUIOSCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 14:02:08 -0400
Received: from c7ns3.center7.com ([216.250.142.14]:64907 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S267235AbUIOSAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 14:00:51 -0400
Message-ID: <41487B6D.1080202@drdos.com>
Date: Wed, 15 Sep 2004 11:27:09 -0600
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: jmerkey@galt.devicelogics.com, linux-kernel@vger.kernel.org,
       jmerkey@comcast.net
Subject: Re: 2.6.8.1 mempool subsystem sickness
References: <091420042058.15928.41475B8000002BA100003E382200763704970A059D0A0306@comcast.net> <4147555C.7010809@drdos.com> <414777EA.5080406@yahoo.com.au> <20040914223122.GA3325@galt.devicelogics.com> <41478419.3020606@yahoo.com.au>
In-Reply-To: <41478419.3020606@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------050902090704030608090904"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050902090704030608090904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:

> jmerkey@galt.devicelogics.com wrote:
>
>> You bet.  Send them to me.  For some reason I am not able to post to 
>> LKML again.
>>
>> Jeff
>>
> OK, this is against 2.6.9-rc2. Let me know how you go. Thanks
>
>  
>

Nick,

The problem is corrected with this patch.  I am running with 3GB of 
kernel memory
and 1GB user space with the userspace splitting patch with very heavy 
swapping
and user space app activity and no failed allocations.  This patch 
should be rolled
into 2.6.9-rc2 since it fixes the problem.  With standard 3GB User/1GB 
kernel
address space, it also fixes the problems with X server running out of 
memory
and the apps crashing.

Jeff

Here's the stats from the test of the patch against 2.6.8-rc2 with the 
patch applied



--------------050902090704030608090904
Content-Type: text/plain;
 name="proc.meminfo"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proc.meminfo"


--------------050902090704030608090904
Content-Type: text/plain;
 name="proc.vmstat"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proc.vmstat"


--------------050902090704030608090904
Content-Type: text/plain;
 name="proc.slabinfo"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="proc.slabinfo"


--------------050902090704030608090904--
