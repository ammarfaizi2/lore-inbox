Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbTLDLRQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 06:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTLDLRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 06:17:16 -0500
Received: from natsmtp01.rzone.de ([81.169.145.166]:27078 "EHLO
	natsmtp01.rzone.de") by vger.kernel.org with ESMTP id S261344AbTLDLRO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 06:17:14 -0500
Message-ID: <3FCF17AD.50504@softhome.net>
Date: Thu, 04 Dec 2003 12:17:01 +0100
From: "Ihar 'Philips' Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030927
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Hockin <thockin@hockin.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fredrik@dolda2000.com, greg@kroah.com
Subject: Re: Why is hotplug a kernel helper?
References: <YPev.5Y5.33@gated-at.bofh.it> <YQkL.81w.41@gated-at.bofh.it> <YR6p.Jy.5@gated-at.bofh.it> <YRzn.1mB.1@gated-at.bofh.it> <YVjJ.7Np.9@gated-at.bofh.it>
In-Reply-To: <YVjJ.7Np.9@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:
> On Wed, Dec 03, 2003 at 06:29:12PM -0800, Greg KH wrote:
> 
>>I would suggest reading this post from Linus for a quick summary:
>>	http://marc.theaimsgroup.com/?l=linux-kernel&m=105552804303171
> 
> 
> I don't really see what's so bad about acpid.  The code is dead simple.
> Now, I'm not saying it is better than hotplug, but I really don't see them
> as being too different.
> 
> Sorry to chime in :)

   I have no idea how acpid/cardmgr bloated.
   So will go abstract.

   But this is common observation: event managers tend to be bloated.
   Rationale: "Let's work around this bug here". Very common.

   I'm implementing couple of event daemons right now - I have had hard 
time to protect them and force bugs being fixed in right place (test 
department screams, driver developers are saying this is "just couple 
lines of codes in daemon and tens in driver" - hopefully I do have good 
management, so B.S. aka bullshit is no go here. I'm really lucky).

   So to not to have hard time doing simple things - hotplug just does 
prohibit complicated/stateful processing implicitely.

   But, yeah, sure, any one can work around it - just make event handler 
a simple redirector to event handling daemon ;-)))

   my 0.02 euros.

P.S. take a look at mount... nfs hooks, smbfs hooks... -o handling is 
just mess. All this mess for you can simply say "mount this there".
Nice ;)

-- 
Ihar 'Philips' Filipau  / with best regards from Saarbruecken.
--                                                           _ _ _
  Because the kernel depends on it existing. "init"          |_|*|_|
  literally _is_ special from a kernel standpoint,           |_|_|*|
  because its' the "reaper of zombies" (and, may I add,      |*|*|*|
  that would be a great name for a rock band).
                                 -- Linus Torvalds

