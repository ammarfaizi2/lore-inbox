Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311454AbSC1CFr>; Wed, 27 Mar 2002 21:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311463AbSC1CFi>; Wed, 27 Mar 2002 21:05:38 -0500
Received: from ip68-7-112-74.sd.sd.cox.net ([68.7.112.74]:24325 "EHLO
	clpanic.kennet.coplanar.net") by vger.kernel.org with ESMTP
	id <S311454AbSC1CFb>; Wed, 27 Mar 2002 21:05:31 -0500
Message-ID: <00c901c1d5fc$ec682e50$7e0aa8c0@bridge>
From: "Jeremy Jackson" <jerj@coplanar.net>
To: "Andre Hedrick" <andre@linux-ide.org>,
        "Benjamin LaHaise" <bcrl@redhat.com>
Cc: "Erik Andersen" <andersen@codepoet.org>, "Jos Hulzink" <josh@stack.nl>,
        "jw schultz" <jw@pegasys.ws>, <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10203271632530.6006-100000@master.linux-ide.org>
Subject: Re: IDE and hot-swap disk caddies
Date: Wed, 27 Mar 2002 18:02:50 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This has been an interesting thread.  A few observations:

-the hdparm utility source dist includes a utility to activate the
Special Hardware in an ? laptop.  So there's the electrical
end taken care of.  The success of it the rest of the way
is made possible by (Linux) OS IDE hotswap support.
Having the OS part working well is a prerequisite for other
hardware/vendor specific magic utilities.  My compaq
laptop docs with a base station, which has the electrical
stuff for hot dock.  I sure wish I could use the IDE in the
base station under Linux after I dock...

-some very cheap IDE swap bays have a mechanical interlock
with the power switch.  Your turn the key, and the drive shuts
off, before you can pull it out.  power sequencing solved? don't
know about ATA133 on something this cheap though. Stll,
*very* useful for cloning drives, backup, sysadmin type stuff.
Just don't forget to tristate before you power off.  The expensive
stuff lets the OS control those two steps.  Kind of like the
difference between Mac/Sparc floppy power eject and PC
manual eject.  I'll still use the manual method, and save myself
hours doing workstation backup and cloning; as long as it exists :)

-PCMCIA has electrical hot swap support...?

Lots of reasons to support it, with a warning.

Jeremy

----- Original Message -----
From: "Andre Hedrick" <andre@linux-ide.org>
> Power is one issue and another is shock on the buss, there are more.
> Get the power wrong (grounding order) and you pull current off the ribbon.
> Pull current of the ribbon, you blue-smoke the other device and or the
> host.  Fail to invoke a tristate block at the device in a master/slave and
> you introduce shock and and data corrution.
>
> Have I made it work in linux in the past safely yes, did it take special
> hardware you bet.  Can you get it OTC, no.  Is is still findable not sure.
> Is there a proper demand that I could go back to the known chip maker and
> board maker to get them to bring it off the shelf, I doubt it.
>
> All the users in Linux (to date) are not a big enough customer base.
> If you think it is big enough, look at the shipping numbers.
> I did this once back in earlier 2000 and got burned as did two companies.

