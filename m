Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269590AbUICKov@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269590AbUICKov (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 06:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269599AbUICKou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 06:44:50 -0400
Received: from [64.147.162.83] ([64.147.162.83]:38083 "EHLO
	thunderbolt.ipaska.net") by vger.kernel.org with ESMTP
	id S269590AbUICKos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 06:44:48 -0400
Date: Fri, 3 Sep 2004 20:43:34 +1000
From: Luke Yelavich <luke@audioslack.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>, Free Ekanayaka <free@agnula.org>,
       Eric St-Laurent <ericstl34@sympatico.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "K.R. Foley" <kr@cybsft.com>,
       Felipe Alfaro Solana <lkml@felipe-alfaro.com>,
       Daniel Schmitt <pnambic@unu.nu>, Mark_H_Johnson@raytheon.com,
       "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>,
       nando@ccrma.stanford.edu, free78@tin.it
Subject: Re: [patch] voluntary-preempt-2.6.9-rc1-bk4-R1
Message-ID: <20040903104334.GA17669@luke-laptop.yelavich.home>
References: <1094192788.19760.47.camel@krustophenia.net> <20040903063658.GA11801@elte.hu> <1094194157.19760.71.camel@krustophenia.net> <20040903070500.GB13100@elte.hu> <1094197233.19760.115.camel@krustophenia.net> <87acw7bxkh.fsf@agnula.org> <1094198755.19760.133.camel@krustophenia.net> <20040903092547.GA18594@elte.hu> <20040903095031.GA22607@luke-laptop.yelavich.home> <20040903102948.GA23726@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040903102948.GA23726@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thunderbolt.ipaska.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - audioslack.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2004 at 08:29:48PM EST, Ingo Molnar wrote:
> * Luke Yelavich <luke@audioslack.com> wrote:
> > I am using a D-Link KVM here between my notebook and my desktop
> > machine. It is the desktop I am currently testing these patches on,
> > and the KVM requires a double-tap of the scroll lock key to switch
> > between machines. With the latest R0 patch, something is not working
> > when I attempt to change from my desktop to my notebook. The KVM
> > usually lets out a beep when I can use the arrow keys to switch, but
> > it isn't here. Adding to that, my console locks up totally for about
> > 10 seconds, before allowing me to go on and type commands. [...]
> 
> i have a KVM too to two testsystems and unfortunately i cannot reproduce
> your problems neither with KVM (key-based-)switching nor with scroll
> lock. But this KVM uses a triple-key combination to switch, not
> scroll-lock.
> 
> it's a PS2 keyboard, right?

Yes, that is correct.

> If yes then does:
> 
> 	echo 0 > /proc/irq/1/i8042/threaded
> 	( maybe also: echo 0 > /proc/irq/12/i8042/threaded )
> 
> fix the problem? The PS2 driver has been a bit unrobust when hardirq
> redirection is enabled.

I only had to turn off IRQ threading for 1, and all is well again.

> 
> > [...] I also seem to get some debugging output or a trace of some sort
> > when rebooting, and the kernel panics with the message: (0)Kernel
> > Panic - not syncing: Failed exception in interrupt
> 
> hm. Would be nice to get a serial console capture of this, if possible.

I am pretty sure I have a cable, however my desktop is the only computer in this
room that has serial ports, and I also don't know how to set up a serial
console. If you feel that this is important, I will see what I can do.
-- 
Luke Yelavich
http://www.audioslack.com
luke@audioslack.com
