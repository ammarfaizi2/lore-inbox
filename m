Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132573AbRDQN4W>; Tue, 17 Apr 2001 09:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132625AbRDQN4N>; Tue, 17 Apr 2001 09:56:13 -0400
Received: from mailhost3.lanl.gov ([128.165.3.9]:2385 "EHLO mailhost3.lanl.gov")
	by vger.kernel.org with ESMTP id <S132573AbRDQN4E>;
	Tue, 17 Apr 2001 09:56:04 -0400
Message-ID: <3ADC4B71.2FE60B57@lanl.gov>
Date: Tue, 17 Apr 2001 07:56:01 -0600
From: Eric Weigle <ehw@lanl.gov>
Organization: CCS-1 RADIANT team
X-Mailer: Mozilla 4.7 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en, es-ES, ex-MX, fr-FR, fr-CA
MIME-Version: 1.0
To: "Bingner Sam J. Contractor RSIS" <Sam.Bingner@hickam.af.mil>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ARP responses broken!
In-Reply-To: <4CDA8A6D03EFD411A1D300D0B7E83E8F6972AC@FSKNMD07.hickam.af.mil>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> oh great, now I wont be able to upgrade our kernels to 2.4 unless I find a
> utility to filter out the ARP requests?
"There's more than one way to do it" (see below)

> Why was this ability removed?
Apparently the decision was made to do it this way because it simplified the
fast path of the code; but I could be wrong. I have yet to achieve Linux Guru
status, right now I'm just some guy who has hit this problem and knows the
work-arounds.

> If I screw up and put it on the wrong card, I WANT the system to stop
> working...
I agree. I'm not making an argument for this implementation. Well, maybe I am;
Linux is intended as a desktop operating system and in that context most people
would rather have the failsafe than the failstop. Perhaps this method is
`inelegant' but it kept up a cluster of machines we have here a lot longer than
they might otherwise have functioned (the gige Acenic driver had some problems a
while back and about half the cards silently failed-- the 'broken' arp responses
meant that we could still talk to those boxes without reconfiguring IPs).

Anyway, Here's links to a discussion that occurred this January.

If you require the 'hidden' functionality, the first message cites the following
links; the patch apparently works with 2.4.x with some tweaking.
    http://www.linuxvirtualserver.org/arp.html
    http://www.linuxvirtualserver.org/hidden-2.3.41-1.diff

http://www.uwsg.indiana.edu/hypermail/linux/kernel/0101.3/0014.html
    http://www.uwsg.indiana.edu/hypermail/linux/kernel/0101.3/0020.html
    http://www.uwsg.indiana.edu/hypermail/linux/kernel/0101.3/0188.html
    http://www.uwsg.indiana.edu/hypermail/linux/kernel/0101.3/0213.html
    http://www.uwsg.indiana.edu/hypermail/linux/kernel/0101.3/0220.html
    http://www.uwsg.indiana.edu/hypermail/linux/kernel/0101.3/0268.html
        http://www.uwsg.indiana.edu/hypermail/linux/kernel/0101.3/0334.html
            http://www.uwsg.indiana.edu/hypermail/linux/kernel/0101.3/0410.html

Hope that helps
-Eric

--------------------------------------------
 Eric H. Weigle   CCS-1, RADIANT team
 ehw@lanl.gov     Los Alamos National Lab
 (505) 665-4937   http://home.lanl.gov/ehw/
--------------------------------------------
