Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265257AbUFHRPA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265257AbUFHRPA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 13:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265258AbUFHRPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 13:15:00 -0400
Received: from mail.tmr.com ([216.238.38.203]:53515 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S265257AbUFHRO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 13:14:57 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [announce] [patch] NX (No eXecute) support for x86,   2.6.7-rc2-bk2
Date: Tue, 08 Jun 2004 13:15:32 -0400
Organization: TMR Associates, Inc
Message-ID: <ca4rv0$p3q$1@gatekeeper.tmr.com>
References: <20040602205025.GA21555@elte.hu> <20040603230834.GF868@wotan.suse.de> <20040604092552.GA11034@elte.hu> <200406040826.15427.luto@myrealbox.com> <Pine.LNX.4.58.0406040830200.7010@ppc970.osdl.org> <20040604154142.GF16897@devserv.devel.redhat.com> <Pine.LNX.4.58.0406040843240.7010@ppc970.osdl.org> <20040604155138.GG16897@devserv.devel.redhat.com> <Pine.LNX.4.58.0406040856100.7010@ppc970.osdl.org> <40C0A87A.3060609@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1086714656 25722 192.168.12.100 (8 Jun 2004 17:10:56 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
In-Reply-To: <40C0A87A.3060609@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> Linus Torvalds wrote:
> 
> 
>>If things are really that good, why are we even worrying about this?
>>
>>It sounds like we should just have NX on by default even for executables
>>that don't have any NX info records,
> 
> 
> This is possible in one of the modes the FC kernel supports but not a
> good default.
> 
> While most of the code we ship has no problems, 3rd party code is a
> completely different story.  Most of the time this code is not as
> cleanly written as the (cleaned-up) code we ship.  If anything, you can
> announce your intention to change the default in a few years and urge
> people to clean up their code.  If you want the maximum protection now
> go with Ingo's exec-shield patch and the /proc/sys/kernel/exec-shield
> entry which can be set to 2 to enable the strict mode.  That's certainly
> the best solution for edge servers but not for application servers
> running lots of dubious 3rd party code.
> 
I have complained about breaking existing programs many times, but in 
this case I think the default should be no exec on all user writable 
data, and let the admin relax the security as needed. Or at least make a 
really obnoxious whine default, so people will know they have to deal 
with what's coming in some (near) future release.

And this should be noted at the top of the ChangeLog for versions where 
it changes, please! This will bite people, I just think it's needed to 
keep Linux the most secure o/s around. Yes, I know about openBSD...

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
