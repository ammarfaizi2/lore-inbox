Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262123AbUKJU15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbUKJU15 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 15:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbUKJUZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 15:25:08 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:9732 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262120AbUKJUWQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 15:22:16 -0500
Message-ID: <41927019.9050508@tmr.com>
Date: Wed, 10 Nov 2004 14:46:33 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.10-rc1 and prev] System unuseable while writing to disk
References: <418FE968.4030300@gmx.de>
In-Reply-To: <418FE968.4030300@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash K. Cheemplavam wrote:
> Hi,
> 
> I have a problem which doesn't seem to be connected to the i/o 
> schedulers, because all I tested (cfq, deadline, noop) show the same:
> 
> While writing (when the kernel actually commits to hd) my system gets 
> very unresponsive esp when another app I want to use wants to write 
> (read?) from hd, as well. This is *not* a UDMA problem (at least no 
> apparent...)! More specific:
> 
> I wrote this primitive code for writing sequentially:

May I suggest running "vmstat 1" while this is happening? Looking at the 
waitio time vs. transfer rates might reveal something. If it all looks 
the same post a small section, if it starts off looking like one thing 
and then changes as buffers fill, data from start to steady state might 
assist someone in helping.

I can't say that I see any such thing with ext[23], so it may be a 
reiser issue and someone else will have to help. Did you look at the 
logs to see that there are no useful warnings there?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

