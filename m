Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265439AbSJXM7A>; Thu, 24 Oct 2002 08:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265447AbSJXM7A>; Thu, 24 Oct 2002 08:59:00 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:44052 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S265439AbSJXM67>;
	Thu, 24 Oct 2002 08:58:59 -0400
Message-ID: <3DB7F01E.8090208@mvista.com>
Date: Thu, 24 Oct 2002 08:05:34 -0500
From: Corey Minyard <cminyard@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dipankar@gamebox.net
CC: linux-kernel@vger.kernel.org, John Levon <levon@movementarian.org>
Subject: Re: [PATCH] NMI request/release, version 4
References: <20021022232345.A25716@dikhow> <3DB59385.6050003@mvista.com> <20021022233853.B25716@dikhow> <3DB59923.9050002@mvista.com> <20021022190818.GA84745@compsoc.man.ac.uk> <3DB5C4F3.5030102@mvista.com> <20021023230327.A27020@dikhow> <3DB6E45F.5010402@mvista.com> <20021024002741.A27739@dikhow> <3DB7033C.1090807@mvista.com> <20021024132004.A29039@dikhow>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:

>Ok, some more comments -
>
>On Wed, Oct 23, 2002 at 03:14:52PM -0500, Corey Minyard wrote:
>  
>
>Can release_nmi() be done from irq context ? If not, I don't see
>why spin_lock_irqsave() is required here. If it can be called
>from irq context, then I can't see how you can schedule()
>(or wait_for_completion() for that matter :)).
>
I originally was using nmi_handler_lock in the rcu routine (which runs 
at interrupt level).  You have to turn off interrupts if someone else 
can claim the lock at interrupt level.  However, I"m not any more, so it 
can go away.

-Corey

