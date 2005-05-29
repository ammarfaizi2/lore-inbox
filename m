Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVE2XHW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVE2XHW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 19:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVE2XHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 19:07:21 -0400
Received: from smtpout.mac.com ([17.250.248.47]:10706 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S261376AbVE2XGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 19:06:51 -0400
In-Reply-To: <Pine.LNX.4.58.0505291543070.10545@ppc970.osdl.org>
References: <1117291619.9665.6.camel@localhost> <Pine.LNX.4.58.0505291059540.10545@ppc970.osdl.org> <84144f0205052911202863ecd5@mail.gmail.com> <Pine.LNX.4.58.0505291143350.10545@ppc970.osdl.org> <1117399764.9619.12.camel@localhost> <Pine.LNX.4.58.0505291543070.10545@ppc970.osdl.org>
Mime-Version: 1.0 (Apple Message framework v728)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <80A1629F-0E91-4CCD-B64D-3AF8C21ECBF6@mac.com>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Pekka Enberg <penberg@gmail.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PROBLEM] Machine Freezes while Running Crossover Office
Date: Sun, 29 May 2005 19:06:29 -0400
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Apple Mail (2.728)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 29, 2005, at 18:59:03, Linus Torvalds wrote:
> On Sun, 29 May 2005, Pekka Enberg wrote:
>> The mouse cursor does not move and the screen does not refresh. The
>> machine locks up completely for few seconds (actually more like  
>> 5-10 s)
>> and then the system comes back up (after which it can be used  
>> normally).
>> I cannot even switch virtual consoles. Please note that I can
>> immediately reproduce the problem again as many times as I want by  
>> doing
>> the test scenario.
>
> However, I don't understand how wine can block the X server from doing
> even cursor updates. It might be a scheduler bug, of course. The  
> one thing
> a bigger pipe buffer does is end up changing scheduling behaviour.
>
> (On the other hand, I would not be surprised if Wine does something  
> that
> makes X pause, like use DGA or whatever and tells X not to update the
> screen, including cursors).

If the application captured the mouse/keyboard and did not pass them  
on to
X for some period of time, then X would appear to not respond to VT- 
switch
requests, because those keys go through the same handler loop  
(depending on
the way your X is configured, of course).

I've had incidents where a user forkbomb was able to hang X (and  
therefore
the console) while our SCHED_RR rate-limited SSH daemon was running fine
and able to successfully kill the process.



Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$  
r  !y?(-)
------END GEEK CODE BLOCK------



