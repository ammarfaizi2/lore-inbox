Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbTJNVlb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 17:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbTJNVlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 17:41:31 -0400
Received: from smtp1.libero.it ([193.70.192.51]:2034 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id S262016AbTJNVl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 17:41:27 -0400
Date: Tue, 14 Oct 2003 23:43:11 +0200
From: "M. Fioretti" <m.fioretti@inwind.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: wli <wli@holomorphy.com>, io <m.fioretti@inwind.it>
Subject: Unbloating the kernel, action list
Message-ID: <20031014214311.GC933@inwind.it>
Reply-To: "M. Fioretti" <m.fioretti@inwind.it>
References: <HMQWM7$61FA432C2B793029C11F4F77EEAABD1F@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HMQWM7$61FA432C2B793029C11F4F77EEAABD1F@libero.it>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

first of all, thanks to all who answered, both on this list and
privately, with congratulations for the RULE project and the
acknowledgement that this is a serious problem.

Many of the answers also asked how to help RULE at the kernel level.
The rest of this message gives a very short background, freely mixing
some replies, and then explains what could be done. Thanks in advance
for reading it all, it is not so long. Any feedback is welcome!

	    Marco Fioretti

############################################################
BACKGROUND:

> ...not everybody can just make their own raw distribution.. and many
> modern distro installers don't like 32MB RAM...

Absolutely! Red Hat got to the point that the installer requirements
became higher than the kernel ones, which is as ugly as can be. We
solved that problem: our installer works in 12 MB. AND it installs
standard stuff from the official Cdroms of the latest stable Red Hat
(soon Fedora). Minimum effort, greatest result: after installation one
goes for support, updates, patches... to the usual Red Hat places, no
more burden for RULE.

> OTOH: why not run an older version of the kernel? Are kernel versions
> 2.2 or even 2.0 really not sufficient for such a situation?

As already mentioned, this is wrong, functionally and security wise.
See the RULE FAQ for details.

> fix all the security issues in ancient versions of the kernel and
> popular userspace applications

See above. That would be a huge effort to still remain without
iptables, Imap, digital signatures, fontconfig, Cups based
printing....

IMPORTANT: the distribution just doesn't matter. We are doing Red Hat
for a whole bunch of purely practical reasons, not for some religious
preference. On older hardware vanilla kernels, X, Gnome, Kde,
Mozilla... are just too much, regardless of the CDs they came from.

############################################################

WHAT TO DO:

Bloat must be fought in four places: installers, userland, X and
kernel. We are already dealing with the first three: apart from the
installer, things like repackaging Abiword to not require Gnome, and
kdrive. Quite honestly, we don't really have the skills and experience
to delve deeply into Linux proper, and here is how you kernel folks
can help:

1) Raise and keep alive the awareness, here and in any other place you
   can, that bloat is a serious practical problem for many people,
   schools, NGOs, etc...Any time you can. Really

2) Prepare, after discussing here, and keep updated, the most complete
   list of tricks you can think of to make the kernel and the rest of
   the system (more on this later) run faster and with less resources.
   Think to the PC you had 6/7 years ago, and work for that. Go to the
   RULE test page, and looks at the PC entries. Everything from
   compilation options to /proc or filesystem settings is useful.

   RULE can and will host happily such a page, but maybe it would be
   better to place it on kernel.org, as it should benefit all Linux
   users.

3) Which kernel and which system? The whole point of RULE is to do the
   job with current mainstream stuff. No point in cornering
   unexperienced users with something nobody else uses. Basically
   everything that would be like making a new distribution
   (nonstandard gcc, glibc, recompiling all userland for it...) is
   interesting, but not useful for us.

4) For us RULE folks, point 3) means that today we really need the
   support of point 2) on the latest official Red Hat 9 kernel, and
   starting from their source RPMs. Things like "once you have it,
   patch the spec file so and so, recompile, then once installed set
   up this and that system parameter". Repeat ad libitum whenever a
   new stable Fedora is released.

5) Again, the distro is not the issue. Once a lean kernel, Kdrive, and
   the right apps are well known, they can go everywhere. Let's work
   at THAT level first. In the meantime, if somebody really feels like
   doing the RULE thing on Debian, Mandrake, Slackware,
   whatever... call me offline and volunteer to maintain the "RULE for
   XYZ" subproject. You'll be welcome.
   More useful, but harder, would be non x86 architectures, people
   keep asking me to resurrect their Sparcs or Macs.

6) subscribe to the RULE mailing list: it is just a tiny fraction of
   the traffic on Linux-Kernel: you won't even notice it, and be there
   when somebody needs help.

7) Do come in suggesting anything I might have forgotten

-- 
Marco Fioretti                 m.fioretti, at the server inwind.it
Red Hat for low memory         http://www.rule-project.org/en/

Go ahead, capitalize the T on technology, deify it if it will make you
feel less responsible -- but it puts you in with the neutered,
brother, in with the eunuchs keeping the harem of our stolen Earth for
the numb and joyless hardons of human sultans, human elite with no
right at all to be where they are --
			       Thomas Pynchon, _Gravity's Rainbow_
