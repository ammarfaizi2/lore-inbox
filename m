Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265128AbSJWR4l>; Wed, 23 Oct 2002 13:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265138AbSJWR4l>; Wed, 23 Oct 2002 13:56:41 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:55058 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S265128AbSJWR4k>;
	Wed, 23 Oct 2002 13:56:40 -0400
Message-ID: <3DB6E45F.5010402@mvista.com>
Date: Wed, 23 Oct 2002 13:03:11 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dipankar@gamebox.net
CC: linux-kernel@vger.kernel.org, John Levon <levon@movementarian.org>
Subject: Re: [PATCH] NMI request/release, version 3
References: <20021022021005.GA39792@compsoc.man.ac.uk> <3DB4B8A7.5060807@mvista.com> <20021022025346.GC41678@compsoc.man.ac.uk> <3DB54C53.9010603@mvista.com> <20021022232345.A25716@dikhow> <3DB59385.6050003@mvista.com> <20021022233853.B25716@dikhow> <3DB59923.9050002@mvista.com> <20021022190818.GA84745@compsoc.man.ac.uk> <3DB5C4F3.5030102@mvista.com> <20021023230327.A27020@dikhow>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:

>On Tue, Oct 22, 2002 at 04:36:51PM -0500, Corey Minyard wrote:
>
>Hmm... I am not sure if this is correct. 
>
Yes, it's not correct, I will fix it.  I didn't realize there was an 
rcu-safe list.  That should make things simpler.

>I probably have missed quite a few things here in these changes, but
>would be interesting to see if they could be made to work. One clear
>problem - someone does a release_nmi() and then a request_nmi() 
>on the same handler while it is waiting for its RCU grace period
>to be over. Oh well :-)
>
Well, the documentation said "Don't do that!".  But I think you are 
right, I will make release_nmi() block until the item is free.

Thanks,

-Corey

