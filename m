Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbUEATMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbUEATMX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 15:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbUEATMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 15:12:23 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:24507 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S261880AbUEATMV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 15:12:21 -0400
In-Reply-To: <6900000.1083388078@[10.10.2.4]>
References: <009701c42edf$25e47390$ca41cb3f@amer.cisco.com> <Pine.LNX.4.58.0404301212070.18014@ppc970.osdl.org> <90DD8A88-9AE2-11D8-B83D-000A95BCAC26@linuxant.com> <6900000.1083388078@[10.10.2.4]>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <772768DC-9BA3-11D8-B83D-000A95BCAC26@linuxant.com>
Content-Transfer-Encoding: 7bit
Cc: Tim Connors <tconnors+linuxkernel1083378452@astro.swin.edu.au>,
       "'lkml - Kernel Mailing List'" <linux-kernel@vger.kernel.org>
From: Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Sat, 1 May 2004 15:12:18 -0400
To: "Martin J. Bligh" <mbligh@aracnet.com>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On May 1, 2004, at 1:07 AM, Martin J. Bligh wrote:

>> All bugs can be debugged or fixed, it's a matter of how hard it is
>> to do (generally easier with open-source) and *who* is responsible
>> for doing it (i.e. supporting the modules).
>
> Yes, exactly. The tainted mechanism is there to tell us that it's not
> *our* problem to support it. And you deliberately screwed that up,
> which is why everybody is pissed at you.

It was already screwed up, and causing unnecessary support burdens
both on the community ("help! what does tainted mean") and vendors.
This thread and previous ones have shown ample evidence of that.
Let's deal with the root problem and fix the messages, as Rik van Riel
has suggested.

Most third-party module suppliers have been confronted with the same 
issue
and forced to work around it (in other imperfect and sometimes clumsy 
ways).
One of them redirects the messages to a separate file and appends
the following notice:

 > ********************************************************************
 > * You can safely ignore the above message about tainting the kernel.
 > * It is completely political and means just that the maintainers of
 > * of modutils package dislike software that is not distributed under
 > * an open source license.
 > ********************************************************************

On Apr 30, 2004, at 10:36 PM, Tim Connors wrote:
>
> What's wrong with the printk setting workaround? Simply write a number
> to the appropriate file before you load the modules.
>
> I just tried googling for the relevant post, but failed...
>
> He doesn't need to wait for the patches to propogate. He can act on
> his own scripts immediately in readiness for the next version.
>
> Easy.

Not. We don't use a script to systematically load the modules,
because they are large and not always required, nor want to
interfere with the system's normal logging.

Manipulating printk settings or redirecting the superfluous
messages elsewhere are also ugly hacks, which can
potentially also divert/hide important messages.

Marc

