Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbVJCTBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbVJCTBl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 15:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932621AbVJCTBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 15:01:41 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:44045 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932620AbVJCTBk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 15:01:40 -0400
Message-ID: <43418036.9040501@tmr.com>
Date: Mon, 03 Oct 2005 15:02:14 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kasper Sandberg <lkml@metanurb.dk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: error in 2.6.14-rc2/rc3 ipw2200 driver
References: <1128140307.13334.6.camel@localhost>
In-Reply-To: <1128140307.13334.6.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Sandberg wrote:
> hello... i have a problem with the ipw2200 driver now merged into
> 2.6.14-rc2..
> 
> it says in dmesg many things..
> 
> eth1 (WE) : Driver using old /proc/net/wireless support, please fix
> driver !
> ipw2200: failed to send RTS_THRESHOLD command
> ipw2200: failed to send FRAG_THRESHOLD command
> fglrx: Unknown symbol verify_area
> ipw2200: failed to send POWER_MODE command
> ipw2200: failed to send TX_POWER command
> ipw2200: failed to send RTS_THRESHOLD command
> ipw2200: No space for Tx
> ipw2200: failed to send FRAG_THRESHOLD command
> ipw2200: No space for Tx
> ipw2200: failed to send POWER_MODE command
> ipw2200: No space for Tx
> ipw2200: failed to send TX_POWER command
> 
> the thing about using /proc/net/wireless comes a million times :) but
> that doesent matter..
> 
> however, i also get more messages, i am unable to connect to a wireless
> network right now, but whenever i do, it says that a firmware error
> occurs, and that it restarts - it works fine, however i get this.. i
> didnt using the ipw2200 module when it wasnt merged..
> 
> 
> also, why merge version 1.0.0? this release gives many headaches, it
> doesent work right, and doesent have monitor mode..
> 
> also, how come when i even myself replace ieee80211 and ipw2200 with
> latest release, and compile, monitor mode doesent work? this seems odd..
> 
> 
> i dont mean to be annoying or complain, but there are alot out there
> with ipw2200.. and it just doesent work with all features in 2.6.14-rc2
> (and i dont see any ipw2200/ieee80211 changes in rc3)
> 
> i would be very happy if you could update/fix the driver in the kernel,
> it does not matter to me which version, just that it works, and monitor
> mode would be really nice too..

If you look back in the list you will see that I asked a similar 
question, and the answer was that v1.0.6 hasn't been sprinkled with holy 
penguin pee by all the right people. There was an explanation of some 
path the code has to take before it goes in the kernel, someone hasn't 
pushed it, or signed it, or something I don't remember. The code follows 
a signoff path through several people or groups, which is good for 
tracking and QC, and bad for fix it now. In any case the base answer to 
your question is "paperwork" and the fix is to pull the working driver 
and latest wireless tools if you don't have them, and put them in yourself.

After that I get a message that it could not load the firmware, followed 
by the stream of crap you mentioned. I put it on the back burner about a 
week ago, every month or so I check to see if I can get rid of Windows, 
and every month the answer is "not without a lot of do it yourself 
applied to each kernel update."

Drop-in ipw2200 support is getting closer, but it's not quite there yet. 
Be patient or do it yourself, it is being worked on.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
