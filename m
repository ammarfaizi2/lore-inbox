Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbUDXE6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbUDXE6P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 00:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbUDXE6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 00:58:14 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:33707 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S261932AbUDXE6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 00:58:13 -0400
Message-ID: <4089F3DD.3000200@candelatech.com>
Date: Fri, 23 Apr 2004 21:58:05 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Miller <miller@techsource.com>
CC: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: File system compression, not at the block layer
References: <Pine.LNX.4.44.0404231300470.27087-100000@twin.uoregon.edu> <Pine.LNX.4.53.0404231624010.1352@chaos> <yw1xoepio24x.fsf@kth.se> <Pine.LNX.4.53.0404231651120.1643@chaos> <40898730.50009@candelatech.com> <408989E3.5010009@techsource.com>
In-Reply-To: <408989E3.5010009@techsource.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:

>> Wouldn't this pretty much guarantee worst-case latency scenario for 
>> reading, since
>> on average at least one of your 32 disks is going to require a full 
>> rotation
>> (and probably a seek) to find it's bit?
> 
> 
> 
> Only for the first bit of a block.  For large streams of reads, the 
> fifos will keep things going, except for occasionally as drives drift in 
> their relative rotation positions which can cause some delays.

So how is that better than using a striping raid that stripes at the
block level or multi-block level?

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

