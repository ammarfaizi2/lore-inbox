Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272031AbRHVPgL>; Wed, 22 Aug 2001 11:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272033AbRHVPgC>; Wed, 22 Aug 2001 11:36:02 -0400
Received: from h131s117a129n47.user.nortelnetworks.com ([47.129.117.131]:50337
	"HELO pcard0ks.ca.nortel.com") by vger.kernel.org with SMTP
	id <S272031AbRHVPf6>; Wed, 22 Aug 2001 11:35:58 -0400
Message-ID: <3B83D1BA.1D8E507@nortelnetworks.com>
Date: Wed, 22 Aug 2001 11:37:30 -0400
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: "Friesen, Christopher [CAR:VS16:EXCH]" <cfriesen@americasm01.nt.com>,
        linux-kernel@vger.kernel.org
Subject: Re: why no call to add_interrupt_randomness() on PPC?
In-Reply-To: <3B83C430.7E5F59C3@nortelnetworks.com.suse.lists.linux.kernel> <oupitfgnmk6.fsf@pigdrop.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> Nobody except for a few really obscure drivers use SA_SAMPLE_RANDOM
> with their interrupt handlers (none on ppc as far as I can see) On
> i386 all the gathering is normally done via the keyboard/mouse drivers
> and the blk interface. The reason e.g. Macs normally do not gather
> entropy is that they're using the new input layer for keyboard and
> mouse which for some reason doesn't feed its events into the entropy
> pool. I believe Wojtech did a patch for it, but I don't know if it has
> been merged into the ppc tree yet.

The reason I'm looking at this is because I'm on a headless net-booting device. 
We properly save and restore the entropy pool on startup/shutdown, but without
using network interrupts we have no way to generate more entropy.  I was looking
at turning on SA_SAMPLE_RANDOM in our network driver, but then I realized that
it would have no effect because it isn't even supported on PPC.

So the upshot seems to be that there is no real reason why it isn't there, it
just hasn't been seen as required.  Am I right?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
