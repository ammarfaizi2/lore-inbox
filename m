Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUDWVPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUDWVPI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 17:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbUDWVPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 17:15:08 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:8107 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S261451AbUDWVPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 17:15:04 -0400
Message-ID: <40898730.50009@candelatech.com>
Date: Fri, 23 Apr 2004 14:14:24 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: File system compression, not at the block layer
References: <Pine.LNX.4.44.0404231300470.27087-100000@twin.uoregon.edu> <Pine.LNX.4.53.0404231624010.1352@chaos> <yw1xoepio24x.fsf@kth.se> <Pine.LNX.4.53.0404231651120.1643@chaos>
In-Reply-To: <Pine.LNX.4.53.0404231651120.1643@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

> Actually not. You need a FIFO to cache your bits into buffers of bytes
> anyway. Depending upon the length of the FIFO, you can "rubber-band" a
> lot of rotational latency. When you are dealing with a lot of drives,
> you are never going to have all the write currents turn on at the same
> time anyway because they are (very) soft-sectored, i.e., block
> replacement, etc.

Wouldn't this pretty much guarantee worst-case latency scenario for reading, since
on average at least one of your 32 disks is going to require a full rotation
(and probably a seek) to find it's bit?

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

