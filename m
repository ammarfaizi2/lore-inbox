Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265178AbTLCU1O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 15:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265182AbTLCU1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 15:27:14 -0500
Received: from main.gmane.org ([80.91.224.249]:38563 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265178AbTLCU06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 15:26:58 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: Linux 2.4 future
Date: Wed, 03 Dec 2003 13:26:56 -0800
Message-ID: <m2k75dzj6n.fsf@tnuctip.rychter.com>
References: <Pine.LNX.4.44.0312011212090.13692-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-Complaints-To: usenet@sea.gmane.org
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.4 (Reasonable Discussion,
 linux)
Cancel-Lock: sha1:mJCwNJLIW9lEn0kMyVSgUa8jsiA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

>>>>> "Marcelo" == Marcelo Tosatti <marcelo.tosatti@cyclades.com>:
 Marcelo> The intention of this email is to clarify my position on 2.4.x
 Marcelo> future.

 Marcelo> 2.6 is becoming more stable each day, and we will hopefully
 Marcelo> see a 2.6.0 release during this month or January.

 Marcelo> Having that mentioned, I pretend to:
[...]
 Marcelo> - From 2.4.25 on, fix only critical/security problems.

I find your statements on 2.6.0 being stable enough for users rather
alarming. I'll use this occasion to write about my gripes with Linux
development, with hopes that perhaps this will help some developers
understand people's needs better.

On my notebook, I have spent the last two years going through regular
painful kernel patching and upgrades. I have never had a fully working
system during that time. At various times, various parts failed to work
correctly: ACPI, software suspend, USB, sound. Also, the kernel is
incomplete and I have had to patch each new release or compile
additional drivers for (at least): ACPI, cpufreq, cryptoapi + loop
driver fix (for reasonable IV calculation), orinoco wireless card,
spectrum24 wireless card, ALSA sound modules and software suspend.

I've seen ABI's change from under me (the tun/tap interface being
changed around 2.4.9 AFAIR). I've seen bugs being ignored [1]. I've seen
2.4 kernels being plain unusable on my hardware (a non-working ACPI
implementation means the hardware will overheat).

Overall, the state of affairs has been rather sad. It is improving now,
with ACPI and software suspend becoming mature. Some of the USB bugs
were fixed around 2.4.21/22 (I think). I finally have a reasonably
stable system to work on [2].

I am terrified of the following scenario, which is extremely probable to
happen soon:

  1) 2.4 is being moved into "pure maintenance" mode and people are
     being encouraged to move to 2.6.
  2) While people slowly start using 2.6, Linus starts 2.7 and all
     kernel developers move on to the really cool and fashionable things
     [3].
  3) 2.6 bug reports receive little attention, as it's much cooler to
     work on new features than fix bugs. Bugs are not fashionable.
  4) In the meantime, third-party vendors are confused and do not
     support any kernel properly [4].

IMHO, Linus should try to enforce a *long* 2.6 testing period after the
"real" 2.6 kernel is out. Starting a new series immediately is a recipe
for disaster, as with the 2.4 kernels.

Also, please remember, that for some people the move to 2.6 is not that
easy. My personal checklist of things that have to work (and some still
do not, for various reasons) for me to migrate:

  -- support for my hardware (of course),
  -- stable software suspend,
  -- crypto support that can mount my filesystem,
  -- VMware kernel modules,
  -- ATI drivers [5].

What are my suggestions? Two main points, I guess:

  1) Please don't stop working (and that does include pulling in new
     stuff) on 2.4, as many people still have to use it.

  2) Please don't start developing 2.7 too soon. Go for at least 6
     months of bug-fixing. During that time, patches with new features
     will accumulate anyway, so it isn't lost time. But it will at least
     prevent people from saying "well, I use 2.7.45 and it works for
     me".

I hope this posting will help some of you understand how some users
feel. I think most of those people who run into these kinds of problems
are not very well represented on this list. I know of at least several
people who have tried installing Linux on a laptop and failed
[6]. You'll never hear from those people here.

--J.

== 
[1] Yes, I think a "please retest with 2.5.69" response is equivalent to
    ignoring a bug report.  I was also rather disappointed by people
    saying they don't care about bug reports from people who are not
    willing to resend them regularly. 2.4 does not have a bug-tracking
    system, which means many bug reports get lost or ignored.

[2] On hardware that's two years old.

[3] I really, really couldn't care less for a new scheduler that makes
    my machine 2% faster overall. I will trade performance for
    correctness at any time. I am willing to think about performance
    when my machine works without freeezing or crashing.

[4] Vendors such as VMware, ATI or NVidia.

[5] Please don't tell me to buy an open-source supported 3D card. I've
    seen such answers before and they are ridiculous. There is no such
    card on the market if you want anything like reasonable performance.

[6] Failed for good reasons, not because of stupid errors, but because
    of the limitations of Linux.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/zlUgLth4/7/QhDoRAm1SAJ0cSH6NnvLPEXK2NRKyN3MOQhqmMgCg5+fW
vGxj8GBJqQgTSBxnWs7MrMc=
=p01M
-----END PGP SIGNATURE-----
--=-=-=--

