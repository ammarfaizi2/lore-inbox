Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbUJXVJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbUJXVJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 17:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbUJXVJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 17:09:26 -0400
Received: from smtp.mailbox.co.uk ([195.82.125.32]:58034 "EHLO
	smtp.mailbox.co.uk") by vger.kernel.org with ESMTP id S261606AbUJXVIz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 17:08:55 -0400
Message-ID: <417C19D5.7050802@jonmasters.org>
Date: Sun, 24 Oct 2004 22:08:37 +0100
From: Jon Masters <jonathan@jonmasters.org>
Organization: World Organi[sz]ation Of Broken Dreams
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: paulmck@us.ibm.com
CC: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, karim@opersys.com
Subject: Re: [RFC][PATCH] Restricted hard realtime
References: <20041023194721.GB1268@us.ibm.com> <1098562921.3306.182.camel@thomas> <20041023212421.GF1267@us.ibm.com> <35fb2e5904102315066c6892aa@mail.gmail.com> <20041024153204.GA1262@us.ibm.com>
In-Reply-To: <20041024153204.GA1262@us.ibm.com>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Paul E. McKenney wrote:

| Thank you for the background!  It has been quite some time since I
| did significant embedded work.  Let's just say that I am glad that
| "embedded CPU" no longer means "8-bit CPU"!  ;-)

Oh it still does, but those cores tend to get farmed out for PSU
controll or some specific subsystem unless you're "deeply embedded".

jcm>> Talk to smartphone manufacturers who currently have dual ARM
jcm>> core designs, one running Linux and the other running an RTOS
jcm>> for the GSM and phone stuff, and they'll say they actually
jcm>> want to reduce the design complexity down to a single core.
jcm>> Talking to people suggests that multicore designs are good
jcm>> in certain situations (such as in the case above), but in
jcm>> general people aren't yet going to respond to your way of
jcm>> doing realtime :-) Yes you do have only one OS in there,
jcm>> maybe that would change opinion, but we're not quite at the
jcm>> point where everything is multicore so you're not going to
jcm>> convince the masses.

| Good points.  Suppose there was a way to get the hard realtime benefits
| using a slight elaboration of this approach that worked on single-core,
| single-threaded CPUs?  Would that be of interest?

I dunno. It might. I think the trouble is that you'll need to convince
people who think they want single core designs that it's not a must.
Although within a little time it'll increasingly be the case that one
has additional cores whether one wants them or not, that's not just yet
even now. Someone will doubtlessly disagree.

| if you are going for the ultimate in response time, you have
| no choice but to run hand-coded assembly language on bare metal (though
| optimizing compilers are improving, so maybe it will soon be hand-coded
| C on bare metal).

Nah. The guys I work with have enough trouble making things time nicely
with precisely coded sequences accounting for every available T state.

| If you are using your computer to digitally modulate
| and synthesize a USA FM radio signal

In this case it's large magnets and probes, but yes. Same concept.

| So, I guess the question is whether 100-microsecond restricted hard
| realtime support in Linux is worth the effort.

Some of the folks I work with think not. I'm not sure yet - many people
seem to be of the opinion that it's not worth it, but we're told that
the Smartphone guys and others without throwaway cores (or to simplify a
design somewhat) really want this. Incidentally, it looks like they'll
be about a bazzion cores in this particular FPGA range before long, so
it'll become increasingly fun finding things for them to do.

| So, again, if there was a way to make this approach work on
| single-threaded single core CPUs, would that be of interest?

I guess it would. But then we've just had a slew of RT implementations
crawl out of the woodwork and wave at us over the past few weeks and
there are three other major RT implementations which combine Linux with
a Microkernel or other external support (RTLinux, RTAI, KURT, etc.).
Perhaps it's worth working on one of the Linux patch projects
(Monta/Ingo/etc.) rather than going all out to implement it all again.

Jon.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBfBnUeTyyexZHHxERAo90AKCTgK8ZZCq4Lqw+a1VHFzhtKOO22ACfQy7E
hwuQzo04bIlxJy5b1VjGA+E=
=4omH
-----END PGP SIGNATURE-----
