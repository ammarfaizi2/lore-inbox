Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTIJJ3R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 05:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbTIJJ3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 05:29:17 -0400
Received: from dyn-ctb-203-221-72-196.webone.com.au ([203.221.72.196]:35845
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S261168AbTIJJ3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 05:29:13 -0400
Message-ID: <3F5EEEDA.7070406@cyberone.com.au>
Date: Wed, 10 Sep 2003 19:28:58 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Galbraith <efault@gmx.de>
CC: Mike Fedyk <mfedyk@matchmail.com>, John Yau <jyau_kernel_dev@hotmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Priority Inversion in Scheduling
References: <LAW10-OE63Zc1WPsAVe0000ab93@hotmail.com> <3F5E6F15.6040507@cyberone.com.au> <6.0.0.22.0.20030910062610.01cfacd8@pop.gmx.net> <20030910053549.GE28279@matchmail.com> <6.0.0.22.0.20030910074121.01c8a220@pop.gmx.net>
In-Reply-To: <6.0.0.22.0.20030910074121.01c8a220@pop.gmx.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Mike Galbraith wrote:

> At 07:35 AM 9/10/2003, Mike Fedyk wrote:
>
>> On Wed, Sep 10, 2003 at 06:42:10AM +0200, Mike Galbraith wrote:
>> > At 02:23 AM 9/10/2003, Nick Piggin wrote:
>> > >Hi John,
>> > >Your mechanism is basically "backboost". Its how you get X to keep a
>> > >high piroirity, but quite unpredictable. Giving a boost to a process
>> > >holding a semaphore is an interesting idea, but it doesn't address 
>> the
>> > >X problem.
>> >
>> > FWIW, I tried the hardware usage bonus thing, and it does cure the X
>> > inversion problem (yeah,  it's a pretty cheezy way to do it).  It also
>> > cures xmms skips if you can't get to the top without hw usage.  I also
>> > tried a cpu limited backboost from/to tasks associated with 
>> hardware, and
>> > it hasn't run amok... yet ;-)
>>
>> Against which scheduler, and when are you going to post the patch?
>
>
> Against stock test-4, but I'm not going to post it.  It's just an 
> experiment to verify that there is another simple way to defeat the X 
> inversion problem (while retaining active list requeue).  Also, 
> backboost is a tricky little bugger, and I thought I'd let Nick know 
> that I had some success with this heavily restricted form.  (global 
> backboost can be down right evil)
>
> If anyone having inversion or concurrency troubles wants to give it a 
> try for grins, they can drop me a line.  My tree tends to morph a lot 
> though, depending on what aspect of scheduling I'm tinkering with at 
> the time.  It currently does well at defeating known starvation 
> issues, but I don't like it's priority distribution much (and it's not 
> destined for inclusion, and it's pretty darn ugly, and I'll likely 
> break it all to pieces again soon, and...;).


Sounds interesting. I my scheduler doesn't have any inversion or
starvation issues that I know of without backboost though. I'd like to
know if you find any.


