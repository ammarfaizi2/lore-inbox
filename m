Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261863AbTLHW1u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 17:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbTLHW1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 17:27:50 -0500
Received: from ns.int.pl ([212.106.140.230]:14604 "EHLO novacom.pl")
	by vger.kernel.org with ESMTP id S261863AbTLHW1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 17:27:48 -0500
Date: Mon, 8 Dec 2003 23:28:42 +0100
From: Rafal Skoczylas <nils@secprog.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.test11 bug
Message-ID: <20031208222842.GA27131@secprog.org>
Reply-To: Rafal Skoczylas <nils@secprog.org>
References: <10kzo-7mZ-11@gated-at.bofh.it> <10m88-2wd-1@gated-at.bofh.it> <10xdJ-28r-23@gated-at.bofh.it> <10xdJ-28r-25@gated-at.bofh.it> <10xdJ-28r-21@gated-at.bofh.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <10xdJ-28r-21@gated-at.bofh.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-12-08 17:20 Linus Torvalds wrote:
> On Mon, 8 Dec 2003, Linus Torvalds wrote:
>> They all look to be (except for the odd last "bad page state" one, which
>> is likely just a result of some _other_ earlier corruption) due to the
>> high bit being cleared. And it's consistent across reboots too, so it's
>> not just some corruption that stayed around in memory.

I have already stuffed kernel source with debugging printk's, etc.,
so hopefully we could more precisely say where the problem is. Anyway
it will probably take quite a long to determine because (as I previously
said in our "private" e-mail exchange) it takes long hours to crash.
(eg. today mlnetd was killed twice but no system crash yet)
Now, I am starting mlnet in a 'while [ 1 ]; do mlnet; done;' loop just
in case it gets killed and let's see what will happen during the night.

>> And every time it's "mlnetd" - which may just be a coincidence (possibly
>> brought on by that being the most commonly run thing on your box), but it
>> certainly looks like it could also be an indication of the source of the
>> corruption.

Well, most of the time I use only X11+ctwm+aterm+vim+gcc (and sometimes
mozilla or xpdf) so the fact is that mlnetd is the best candidate for
such things since it is the only one on my box which uses resources so
intensively (a few hundrets open sockets constantly being opened and
closed, ram usage ~10% of 512MB, cpu usage ~20% of D1200, etc.).

>> I'll have to think about this, but quite frankly I'm also hoping to see
>> more of a pattern about what this is all about. Can you keep your oopses
>> up somewhere? Maybe opening a bug on bugme.osdl.org? Even though I don't
>> use bugme personally, it's good to keep the record around when we don't
>> immediately see the reason for something..

Sure, I will keep all the oopses. For now I'm gonna collect them on
my webpage in http://secprog.org/who/rs/linux/ (I will report when there
is something new so there is no need to poll() ;>). And then if you are
interested in registering them in bugme, will do it.

Btw. Linus, there is no need CC'ing messages to my e-mail. I will follow
this thread on lkml.

nils.
-- 
"Blessed is the man, who having nothing to say, abstains from giving wordy
evidence of the fact."  -- http://secprog.org/who/rs/quote.php?id=1
