Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751074AbVLGOPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751074AbVLGOPk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 09:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbVLGOPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 09:15:40 -0500
Received: from smtpout.mac.com ([17.250.248.88]:51440 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751071AbVLGOPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 09:15:39 -0500
In-Reply-To: <Pine.LNX.4.61.0512071319320.1609@scrub.home>
References: "dlang@dlang.diginsite.com" <Pine.LNX.4.62.0512011734020.10276@qynat.qvtvafvgr.pbz> <Pine.LNX.4.61.0512021124360.1609@scrub.home> <4396ACF5.3050204@andrew.cmu.edu> <Pine.LNX.4.61.0512071319320.1609@scrub.home>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0EA7F687-BB3F-4CC2-953E-EEA057F6FC44@mac.com>
Cc: James Bruce <bruce@andrew.cmu.edu>,
       David Lang <david.lang@digitalinsight.com>,
       Steven Rostedt <rostedt@goodmis.org>, johnstul@us.ibm.com,
       george@mvista.com, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       ray-gmail@madrabbit.org, Russell King <rmk+lkml@arm.linux.org.uk>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [patch 00/43] ktimer reworked
Date: Wed, 7 Dec 2005 09:15:32 -0500
To: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 07, 2005, at 07:34, Roman Zippel wrote:
> Hi,
>
> On Wed, 7 Dec 2005, James Bruce wrote:
>> And that's the whole *point* about how we got here.  Let the low  
>> resolution, low lifetime timeouts stay on the timer wheel, and  
>> make a new approach that specializes in handling longer lifetime,  
>> higher resolution timers.  That's ktimers in a nutshell.  You seem  
>> to be arguing for it rather than against it.
>
> I do, just without the focus on the lifetime, which is really  
> unimportant for most kernel developers.

It _is_ important.  Not because kernel developers do care about it,  
but because it's important for reasons of its own and therefore they  
should.  Networking timeouts and highres audio timers are two _VERY_  
different applications of "do this thing then", and kernel developers  
should be made aware of them.  If you disagree, please explain in  
detail exactly why you think the lifetime is unimportant.  I have yet  
to see an email regarding this, and I've searched the archives pretty  
carefully, in addition to watching this thread.

Cheers,
Kyle Moffett

--
I lost interest in "blade servers" when I found they didn't throw  
knives at people who weren't supposed to be in your machine room.
   -- Anthony de Boer


