Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293246AbSBQSAD>; Sun, 17 Feb 2002 13:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293247AbSBQR7y>; Sun, 17 Feb 2002 12:59:54 -0500
Received: from duracef.shout.net ([204.253.184.12]:20233 "EHLO
	duracef.shout.net") by vger.kernel.org with ESMTP
	id <S293246AbSBQR7k>; Sun, 17 Feb 2002 12:59:40 -0500
Date: Sun, 17 Feb 2002 11:59:27 -0600
From: Michael Elizabeth Chastain <mec@shout.net>
Message-Id: <200202171759.g1HHxRS30551@duracef.shout.net>
To: jgarzik@mandrakesoft.com
Subject: Re: Disgusted with kbuild developers
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm the creator and one of the current administrators of the kbuild-devel
mailing list.  kbuild-devel is not an instrument of "cronyism" or
"secret meetings".

I think it's reasonable and scalable for kernel subsystems to have their
own mailing lists.  And I think it's reasonable to expect people who
have an interest in a subsystem to look in MAINTAINERS for any mailing
lists and web sites for that subsystem.  As of 2.5.4, the MAINTAINERS
file lists 91 such mailing lists, including:

  CONFIGURE, MENUCONFIG, XCONFIG
  L: kbuild-devel@lists.sourceforge.net
  W: http://kbuild.sourceforge.net

Yeah, some cabal I started here, cleverly hidden in MAINTAINERS.

When Eric Raymond started the CML2 project, he came to the CML1 maintainer
(me) and asked me what I thought.  I referred him to the public list and
we had a public discussion about the project.  The root of the discussion
is here:

  http://www.torque.net/kbuild/archive/0181.html

So while people are chastising Eric for bundling controversial
improvements with CML2, or pushing for a 2.4 backport, or writing in
python, or writing in python2, I think it's unfair to suggest that he
developed CML2 in secret.  He didn't.  He read the MAINTAINERS file
and then held numerous discussions in the appropriate public forum.
You may reject the fruits of his project, but I'm here to say that he
developed it in an open fashion.

(I have to say, reluctantly, that I'm personally not happy with the tactic
of asking kbuild-devel people to send mail to Dirk Hohndel.  I don't have
any acquaintance with Dirk, but I'm sure that he's capable of writing
to kbuild-devel himself if he wants to solicit opinions from there.
I say "reluctantly" because as an administrator of the list, I don't want
to get into criticism of list postings.)

As far as CML1 goes: I got discouraged in April 2000, when Linus
blackholed documentation patches from me for several months in a row.
So I took a hiatus for two years.  Two things have changed since then:
Linus agreed to be more responsive, and other people (specifically Dave
Jones) are offering kernel trees.  So I'm going to give it another shot.
I'm responding to every CML1 patch and bug report which is submitted to
kbuild-devel, and I'm sending patches to Linus and Dave.

I believe that CML1 is rococo and I welcome a replacement.  I think that
leapfrog development is a good strategy here, just as it was for ALSA.
I'll look after the current system, and other people can focus their
attention on the next generation.

Here are my reasons for wanting to get rid of CML1:

. A Microsoft engineer wrote scripts/Configure.  For three years, I have
  lived in fear that Microsoft would notice this fact and use it to attack
  Linux through public relations channels or legal means.  They haven't yet,
  so I have been wrong so far.

. A language must have a written definition, so that people writing
  scripts in the language have a good chance that their scripts will keep
  working as other people enhance the configuration tools.  CML1 has
  a retro-fitted language definition with lots of gaps in it.  

. An implementation must have a real parser that gives real syntax errors.
  Menuconfig in particular likes to get all weird if there are syntax
  errors in the input.  xconfig used to crash a lot in those cases;
  but it has gotten better.

. The language itself does not scale up to the thousands of symbols that
  we have today.  There's a fundamental tension between "hide all the
  symbols for busses that I don't have" and "I want this feature,
  so auto-enable everything I need to get it".

As far as which way to replace CML1 goes: I'm not worried about the
technical specifications of the language, so long as it has one.  I would
like to remove every trace of Microsoft intellectual property from the
kernel, which is an argument in favor of a new language as well
as a new implementation.  I would like the new system to come with plenty
of documentation.  And I would like the new system to have a maintainer
who really believes in it.  CML2 has these properties so I support it.

Other projects, such as Christoph Hellwig's current version of mconfig,
also have these properties (except for keeping the same language) and
are also viable replacements for configure/Menuconfig/xconfig.

Michael Elizabeth Chastain
<mailto:mec@shout.net>
"love without fear"
