Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268991AbUJQBuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268991AbUJQBuM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 21:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268995AbUJQBuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 21:50:12 -0400
Received: from lakermmtao03.cox.net ([68.230.240.36]:1775 "EHLO
	lakermmtao03.cox.net") by vger.kernel.org with ESMTP
	id S268991AbUJQBuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 21:50:07 -0400
In-Reply-To: <1097976283.2148.34.camel@krustophenia.net>
References: <41650CAF.1040901@unimail.com.au> <20041007103210.GA32260@atrey.karlin.mff.cuni.cz> <yw1x7jq2n6k3.fsf@mru.ath.cx> <20041007143245.GA1698@openzaurus.ucw.cz> <1097956343.2148.17.camel@krustophenia.net> <1097963167.13226.4.camel@localhost.localdomain> <1097976283.2148.34.camel@krustophenia.net>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <DE7A72B5-1FDE-11D9-8195-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       M <mru@mru.ath.cx>, Alan Cox <alan@lxorguk.ukuu.org.uk>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: High pitched noise from laptop: processor.c in linux 2.6
Date: Sat, 16 Oct 2004 21:50:05 -0400
To: Lee Revell <rlrevell@joe-job.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 16, 2004, at 21:24, Lee Revell wrote:
> I was not there but I imagine this involves a way to get 1khz accuracy
> with a 100Hz timer interrupt rate?

I think the idea is to (depending on the hardware) dynamically adjust 
the
system timers to exactly the time necessary.  If you don't have any 
important
processes that will interrupt within the next 10ms then you can just go
ahead and set the timer longer.  If properly done you might even be able
to set HZ to 20 or 50.  Hardware interrupts would trigger immediate
responses, but otherwise a non-interactive system could minimize the
number of context switches and make the processor cache that much
more useful.  This would still be bad on an interactive/desktop system
because it would mean that perceptive users could detect the switching
if they have two computationally intensive jobs running simultaneously.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


