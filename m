Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291123AbSBQWHu>; Sun, 17 Feb 2002 17:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291122AbSBQWHa>; Sun, 17 Feb 2002 17:07:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62225 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S291077AbSBQWH3>;
	Sun, 17 Feb 2002 17:07:29 -0500
Message-ID: <3C702999.95BCA136@mandrakesoft.com>
Date: Sun, 17 Feb 2002 17:07:21 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Elizabeth Chastain <mec@shout.net>
CC: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
In-Reply-To: <200202171759.g1HHxRS30551@duracef.shout.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Elizabeth Chastain wrote:
> I'm the creator and one of the current administrators of the kbuild-devel
> mailing list.  kbuild-devel is not an instrument of "cronyism" or
> "secret meetings".
[reshuffle the message a bit]
> (I have to say, reluctantly, that I'm personally not happy with the tactic
> of asking kbuild-devel people to send mail to Dirk Hohndel.  I don't have
> any acquaintance with Dirk, but I'm sure that he's capable of writing
> to kbuild-devel himself if he wants to solicit opinions from there.
> I say "reluctantly" because as an administrator of the list, I don't want
> to get into criticism of list postings.)

I never meant to suggest that about kbuild-devel -- having the
appearance of being an attempt to [IMO] push a bad change via Dirk when
pushing it other ways [IMO] failed was really offensive to me...


> I think it's reasonable and scalable for kernel subsystems to have their
> own mailing lists.

No argument

> So while people are chastising Eric for bundling controversial
> improvements with CML2, or pushing for a 2.4 backport, or writing in
> python, or writing in python2, I think it's unfair to suggest that he
> developed CML2 in secret.  He didn't.

No one's suggesting that.  It's more the appearance of "I couldn't do it
the normal way, let me try this other, non-open route..."


> I believe that CML1 is rococo and I welcome a replacement.  I think that
> leapfrog development is a good strategy here, just as it was for ALSA.

I think this is a key mistake.  See Al's message "Of Bundling, Dao,
...".

It's impossible to prove that Eric's CML2 rulebase reflects a current
CML1 rulebase, primarily for this reason.  My review of arch/alpha/* and
drivers/net/* configs between CML1 and CML2 showed divergent rules and
dependencies which simply don't exist in CML1 and often should not in
CML2.

Surely we can prove through -evolution- that CML2 is or is not the best
direction for the future.  All or nothing is this case is impossible to
prove correctness.


> Here are my reasons for wanting to get rid of CML1:

no arguments


> As far as which way to replace CML1 goes: I'm not worried about the
> technical specifications of the language, so long as it has one.  I would
> like to remove every trace of Microsoft intellectual property from the
> kernel, which is an argument in favor of a new language as well
> as a new implementation.  I would like the new system to come with plenty
> of documentation.  And I would like the new system to have a maintainer
> who really believes in it.  CML2 has these properties so I support it.

Those are meta-properties.  The origin of code, be it MicroSoft or not,
should not be a factor.  In fact, -allowing- it to be a factor is
allowing MicroSoft some additional weight in technical decisions, which
should not occur IMO.

CML2 has global dependencies that the current system does not.

CML2 has a rulebase which is different from the current rulebase, with
no documentation or adequate explanation for these changes, and with no
good way to prove these changes are correct and reflect the current
rulebase for [pick your tree].

CML2's syntax is not reflective of the direction of being able to plop
down "driver.c" and "driver.conf" and having the config/make system
magically notice it.  It goes in the opposite direction, increasing the
number of places in $cml-rules-file that one must patch when adding a
driver [especially one with strange arch-specific dependencies, such as
an S/390-specific net driver].


> Other projects, such as Christoph Hellwig's current version of mconfig,
> also have these properties (except for keeping the same language) and
> are also viable replacements for configure/Menuconfig/xconfig.

Would you support the replacement of in-kernel
configure/Menuconfig/xconfig with in-kernel mconfig?

I mentioned this to Christoph, and he violently disagreed that it should
go into the kernel, and I violently disgreed with him :)  The kernel
absolutely MUST have some in-kernel configuration currently.  And
mconfig is clearly a better tool.

If we want to migrate to a point where all kernel configuration is
maintained solely outside the kernel, I actually support that.  But as a
SEPARATE migration step.  I do not want to drop all config tools from
the kernel and tell people "use mconfig" in the same breath.

	Jeff


-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
