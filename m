Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264681AbSJUA5Y>; Sun, 20 Oct 2002 20:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264684AbSJUA5Y>; Sun, 20 Oct 2002 20:57:24 -0400
Received: from smtp09.iddeo.es ([62.81.186.19]:3558 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S264681AbSJUA5X>;
	Sun, 20 Oct 2002 20:57:23 -0400
Date: Mon, 21 Oct 2002 03:03:27 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Any hope of fixing shutdown power off for SMP?
Message-ID: <20021021010327.GC14334@werewolf.able.es>
References: <Pine.LNX.3.96.1021020204830.1444A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.3.96.1021020204830.1444A-100000@gatekeeper.tmr.com>; from davidsen@tmr.com on Mon, Oct 21, 2002 at 02:52:45 +0200
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.10.21 Bill Davidsen wrote:
>On Mon, 21 Oct 2002, J.A. Magallon wrote:
>
>> 
>> On 2002.10.20 Jurriaan wrote:
>> >From: Bill Davidsen <davidsen@tmr.com>
>> >Date: Sat, Oct 19, 2002 at 03:40:22PM -0400
>> >> I've beaten this dead horse before, but it still irks me that Linux can't
>> >> power down an SMP system. People claim that it can't be done safely, but
>> >> maybe somone can reverse engineer NT if we aren't up to the job.
>> >> 
>> >I'm trying to find out the same. So far:
>> >
>> 
>> There are patches both in the -ac and -aa tree to make smp kernels shut
>> down properly, even to support full APM if you have enough luck. shutdown
>> works fine on my smp box...
>
>I'm kind of out of time to play any more, I think I'm going to leave
>2.5.43 where it is (lots of stuff not working), send the patches to -mm3
>and think about 2.5.44. That should be less volatile since Linus is out.
>
>I can't get apm to even load, it whines in depmod about missing stuff, and
>I've got about two days of my so-called vacation in what I do hve working,
>so a good time to call it a version.
>
>Thanks for the pointer, I'll try -aa and -ac kernels again at .44.
>

Oops, you talk about 2.5...
My pointers were about 2.4. Anyways, perhaps it is the same problem. Both
trees did not shutdown properly because shutdown waited inifinitely for
the apm task to schedule on cpu 0 due to bad interaction with O1
scheduler.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-pre11-jam1 (gcc 3.2 (Mandrake Linux 9.0 3.2-2mdk))
