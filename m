Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWDQQfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWDQQfu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 12:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWDQQfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 12:35:50 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:968 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1750782AbWDQQft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 12:35:49 -0400
Message-ID: <4444171B.90507@cmu.edu>
Date: Mon, 17 Apr 2006 18:30:51 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20060323)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       matt.keenan@btinternet.com
Subject: Re: want to randomly drop packets based on percent
References: <444345F9.4090100@cmu.edu> <20060417091915.67e28361@localhost.localdomain>
In-Reply-To: <20060417091915.67e28361@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Stephen Hemminger wrote:

>On Mon, 17 Apr 2006 03:38:33 -0400
>George Nychis <gnychis@cmu.edu> wrote:
>
>  
>
>>Hey,
>>
>>I'm using the 2.4.32 kernel with madwifi and iproute2 version 
>>2-2.6.16-060323.tar.gz
>>
>>I wanted to insert artificial packet loss based on a percent so i found:
>>network emulab qdisc could do it, so i compiled support into the kernel 
>>and tried:
>>tc qdisc change dev eth0 root netem loss .1%
>>    
>>
>
>Most likely, you the version of the kernel you are running was not
>configured with netem enabled.
>
>  
>
Hey Stephen,

I have netem enabled in the kernel... I've checked this numerous times.  
I enabled it under Networking Options -> QoS -> Network emulator.  I 
even did a make clean, make mrproper, and rebuilt from scratch.

Maybe I'll try compiling it as a module and see if anything changes.

Any other ideas?

----

In response to Matt:
Thank you!

One last question, if I take this route, what is the easiest way to 
allow me to change the packet loss without hard coding a percent into 
the kernel?
