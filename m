Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264095AbUD0Pmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbUD0Pmw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 11:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264184AbUD0Pmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 11:42:45 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:45322 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264191AbUD0PlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 11:41:24 -0400
Message-ID: <408E8012.1080400@techsource.com>
Date: Tue, 27 Apr 2004 11:45:22 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: File system compression, not at the block layer
References: <Pine.LNX.4.44.0404231300470.27087-100000@twin.uoregon.edu> <Pine.LNX.4.53.0404231624010.1352@chaos> <yw1xoepio24x.fsf@kth.se> <Pine.LNX.4.53.0404231651120.1643@chaos> <40898730.50009@candelatech.com> <408989E3.5010009@techsource.com> <4089F3DD.3000200@candelatech.com>
In-Reply-To: <4089F3DD.3000200@candelatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ben Greear wrote:
> Timothy Miller wrote:
> 
>>> Wouldn't this pretty much guarantee worst-case latency scenario for 
>>> reading, since
>>> on average at least one of your 32 disks is going to require a full 
>>> rotation
>>> (and probably a seek) to find it's bit?
>>
>>
>>
>>
>> Only for the first bit of a block.  For large streams of reads, the 
>> fifos will keep things going, except for occasionally as drives drift 
>> in their relative rotation positions which can cause some delays.
> 
> 
> So how is that better than using a striping raid that stripes at the
> block level or multi-block level?
> 


It's only better for large streaming writes.  The FIFOs I'm talking 
about above would certainly be smaller than typical RAID0 stripes.

