Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVCGBO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVCGBO4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 20:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbVCGBOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 20:14:19 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:47265 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S261616AbVCGBNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 20:13:45 -0500
Message-ID: <422BAAC6.6040705@candelatech.com>
Date: Sun, 06 Mar 2005 17:13:42 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christian Schmid <webmaster@rapidforum.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
References: <4229E805.3050105@rapidforum.com>
In-Reply-To: <4229E805.3050105@rapidforum.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schmid wrote:
> Hello.
> 
> After weeks of work, I can now give a detailed report about the bug and 
> when it appears:
> 
> Attached is another traffic-image. This one is with 2.6.10 and a 3/1 
> split, preemtive kernel, so all defaults.

What are the units on your graph.  You say "MB" several places, but
do you mean Mb (ie, Mega-bit) instead?

I have a tool that can also generate TCP traffic on a large number of
sockets.  If I can understand what you are trying to do, I may be able
to reproduce the problem.  My biggest machine at present has only
2GB of RAM, however...not sure if that matters or not.

Are you sending traffic in only one direction, or more of a full-duplex
configuration?  Is each socket running the same bandwidth?  What is this
bandwidth?  Are you setting the send & rcv buffers in the socket creation
code?  (To what values if so?)  How many bytes are you sending with each
call to write()/sendto() whatever?

Is there any significant latency between your sender and receiver machine?
If so, how much?

What is the physical transport...GigE?  1500 MTU?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

