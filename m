Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbVJTXWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbVJTXWO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 19:22:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbVJTXWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 19:22:14 -0400
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:57757 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S964802AbVJTXWO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 19:22:14 -0400
Message-ID: <435826BB.1030809@tmr.com>
Date: Thu, 20 Oct 2005 19:22:35 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jakma <paul@clubi.ie>
CC: Horms <horms@verge.net.au>, linux-kernel@vger.kernel.org,
       Rudolf Polzer <debian-ne@durchnull.de>, 334113@bugs.debian.org,
       Alastair McKinstry <mckinstry@debian.org>, security@kernel.org,
       team@security.debian.org, secure-testing-team@lists.alioth.debian.org
Subject: Re: kernel allows loadkeys to be used by any user, allowing for 
  local root compromise
References: <E1EQofT-0001WP-00@master.debian.org> <20051018044146.GF23462@verge.net.au> <m37jcakhsm.fsf@defiant.localdomain> <Pine.LNX.4.63.0510200340280.3396@sheen.jakma.org>
In-Reply-To: <Pine.LNX.4.63.0510200340280.3396@sheen.jakma.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jakma wrote:
> On Tue, 18 Oct 2005, Krzysztof Halasa wrote:
> 
>> OTOH I don't know why ordinary users should be allowed to change key
>> bindings.
> 
> 
> I like to load a custom keymap to swap ctrl and caps-lock.
> 
> I'd like to keep that ability, but I'd much prefer if it didn't affect 
> all VTs, and if it didn't persist past the end of my session.

I believe in security, no matter how inconvenient, but it would be 
desirable to allow the user to reload the keymap, and the character set 
as well, only for the session in use. The solution would seem to lie in 
having an unchanging SAK key, and on exit from a session absolutely 
reset everything.

Clearly this would take some rethinking and a fair amount of work, so 
the right thing to do is use capabilities to block misuse until/unless 
convenience can be made secure.

Key mapping as a whole sucks, you have the map you get in a vt, which is 
ignored by X which maps its own, except when an X app remaps it yet 
again locally. Lots of room for both evil and stupidity.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
